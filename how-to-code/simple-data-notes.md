# **How To Design Functions (HtDF)**

The HtDF recipe consists of the following steps:

1. Signature, purpose and stub.
2. Define examples, wrap each in check-expect.
3. Template and inventory.
4. Code the function body.
5. Test and debug until correct

```
;; Number -> Number
;; produces n times 2
(check-expect (double 0) (* 0 2))
(check-expect (double 1) (* 1 2))
(check-expect (double 3) (* 3 2))

;(define (double n) 0) ; this is the stub

;(define (double n)    ; this is the template
;  (... n))

(define (double n)
  (* n 2))
```

# **How To Design Data (HTDD)**

The first step of the recipe is to identify the inherent structure of the information.

Once that is done, a data definition consists of four or five elements:

1. A possible **structure definition** (not until compound data)
2. A **type comment** that defines a new type name and describes how to form data of that type.
3. An **interpretation** that describes the correspondence between information and data.
4. One or more **examples** of the data.
5. A **template** for a 1 argument function operating on data of this type.

In the first weeks of the course we also ask you to include a list of the **template rules** used to form the template.

| When the form of the information to be represented... | Use a data definition of this kind |
| --- | --- |
| is atomic | Simple Atomic Data |
| is numbers within a certain range | Interval |
| consists of a fixed number of distinct items | Enumeration |
| is comprised of 2 or more subclasses, at least one of which is not a distinct item | Itemization |
| consists of two or more items that naturally belong together | Compound data |
| is naturally composed of different parts | References to other defined type |
| is of arbitrary (unknown) size | self-referential or mutually referential |

## Simple Atomic Data

Use simple atomic data **when the information to be represented is itself atomic in form**, such as the elapsed time since the start of the animation, the x coordinate of a car or the name of a cat.

```
;; Time is Natural
;; interp. number of clock ticks since start of game

(define START-TIME 0)
(define OLD-TIME 1000)

#;
(define (fn-for-time t)
  (... t))

;; Template rules used:
;;  - atomic non-distinct: Natural
```

### Guidance on Data Examples and Function Example/Tests

One or two data examples are usually sufficient for simple atomic data.

## **Intervals**

```
;; Countdown is Integer[0, 10]
;; interp. the number of seconds remaining to liftoff
(define C1 10)  ; start
(define C2 5)   ; middle
(define C3 0)   ; end

#;
(define (fn-for-countdown cd)
  (... cd))

;; Template rules used:
;;  - atomic non-distinct: Integer[0, 10]
```

### Guidance on Data Examples and Function Example/Tests

For data examples provide sufficient examples to illustrate how the 
type represents information. The three data examples above are probably 
more than is needed in that case.

When writing tests for functions operating on intervals be sure to 
test closed boundaries as well as midpoints. As always, be sure to 
include enough tests to check all other points of variance in behaviour 
across the interval.

## **Enumerations**

```
;; LightState is one of:
;;  - "red"
;;  - "yellow"
;;  - "green"
;; interp. the color of a traffic light

;; <examples are redundant for enumerations>

#;
(define (fn-for-light-state ls)
  (cond [(string=? "red" ls) (...)]
        [(string=? "yellow" ls) (...)]
        [(string=? "green" ls) (...)]))
;; Template rules used:
;;  - one of: 3 cases
;;  - atomic distinct: "red"
;;  - atomic distinct: "yellow"
;;  - atomic distinct: "green"
```

### Guidance on Data Examples and Function Example/Tests

Data examples are redundant for enumerations.

Functions operating on enumerations should have (at least) as many tests as there are cases in the enumeration

## **Itemizations**

```
;; Bird is one of:
;;  - false
;;  - Number
;; interp. false means no bird, number is x position of bird

(define B1 false)
(define B2 3)

#;
(define (fn-for-bird b)
  (cond [(false? b) (...)]
        [(number? b) (... b)]))
;; Template rules used:
;;  - one of: 2 cases
;;  - atomic distinct: false
;;  - atomic non-distinct: Number
```

### Guidance on Data Examples and Function Example/Tests

As always, itemizations should have enough data examples to clearly illustrate how the type represents information.

Functions operating on itemizations should have at least as many 
tests as there are cases in the itemizations. If there are intervals in 
the itemization, then there should be tests at all points of variance in
 the interval. In the case of adjoining intervals it is critical to test
 the boundaries.

## **Itemization of Intervals**

```
;;; Reading is one of:
;;  - Number[> 30]
;;  - Number(5, 30]
;;  - Number[0, 5]
;; interp. distance in centimeters from bumper to obstacle
;;    Number[> 30]    is considered "safe"
;;    Number(5, 30]   is considered "warning"
;;    Number[0, 5]    is considered "dangerous"
(define R1 40)
(define R2 .9)

(define (fn-for-reading r)
  (cond [(< 30 r) (... r)]
        [(and (<  5 r) (<= r  30)) (... r)]
        [(<= 0 r 5) (... r)]))

;; Template rules used:
;;  one-of: 3 cases
;;  atomic non-distinct:  Number[>30]
;;  atomic non-distinct:  Number(5, 30]
;;  atomic non-distinct:  Number[0, 5]
```

## **Compound data (structures)**

```
(define-struct ball (x y))
;; Ball is (make-ball Number Number)
;; interp. a ball at position x, y

(define BALL-1 (make-ball 6 10))

#;
(define (fn-for-ball b)
  (... (ball-x b)     ;Number
       (ball-y b)))   ;Number
;; Template rules used:
;;  - compound: 2 fields
```

### Guidance on Data Examples and Function Example/Tests

For compound data definitions it is often useful to have numerous 
examples, for example to illustrate special cases. For a snake in a 
snake game you might have an example where the snake is very short, very
 long, hitting the edge of a box, touching food etc. These data examples
 can also be useful for writing function tests because they save space 
in each check-expect

## **References to other data definitions**

```
---assume Ball is as defined above---

(define-struct game (ball score))
;; Game is (make-game Ball Number)

;; interp. the current ball and score of the game

(define GAME-1 (make-game (make-ball 1 5) 2))

#;
(define (fn-for-game g)
  (... (fn-for-ball (game-ball g))
       (game-score g)))      ;Number
;; Template rules used:
;;  - compound: 2 fields
;;  - reference: ball field is Ball
```

### Guidance on Data Examples and Function Example/Tests

For data definitions involving references to non-primitive types the 
data examples can sometimes become quite long. In these cases it can be 
helpful to define well-named constants for data examples for the 
referred to type and then use those constants in the referring from 
type. For example:

```
...in the data definition for Drop...
(define DTOP (make-drop 10 0))            ;top of screen
(define DMID (make-drop 20 (/ HEIGHT 2))) ;middle of screen
(define DBOT (make-drop 30 HEIGHT))       ;at bottom edge
(define DOUT (make-drop 40 (+ HEIGHT 1))) ;past bottom edge

...in the data definition for ListOfDrop...
(define LOD1 empty)
(define LOD-ALL-ON             (cons DTOP (cons DMID )))
(define LOD-ONE-ABOUT-TO-LEAVE (cons DTOP (cons DMID (cons DBOT empty))))
(define LOD-ONE-OUT-ALREADY    (cons DTOP (cons DMID (cons DBOT (cons DOUT empty)))))

```

In the case of references to non-primitive types the function operating on the referring type (i.e. ListOfDrop) will end up with a call to a helper that operates on the referred to type (i.e. Drop).
 Tests on the helper function should fully test that function, tests on 
the calling function may assume the helper function works properly

## **Self-referential or mutually referential**

In order to be well-formed, a self-referential data definition must:

- (i) have at least one case without self reference (the base case(s))
- (ii) have at least one case with self reference

```
;; ListOfString is one of:
;;  - empty
;;  - (cons String ListOfString)
;; interp. a list of strings

(define LOS-1 empty)
(define LOS-2 (cons "a" empty))
(define LOS-3 (cons "b" (cons "c" empty)))

#;
(define (fn-for-los los)
  (cond [(empty? los) (...)]                   ;BASE CASE
        [else (... (first los)                 ;String
                   (fn-for-los (rest los)))])) ;NATURAL RECURSION
;;             /
;;            /
;;       COMBINATION
;; Template rules used:
;;  - one of: 2 cases
;;  - atomic distinct: empty
;;  - compound: (cons String ListOfString)
;;  - self-reference: (rest los) is ListOfString
```

or

```
(define-struct dot (x y))
;; Dot is (make-dot Integer Integer)
;; interp. A dot on the screen, w/ x and y coordinates.
(define D1 (make-dot 10 30))
#;
(define (fn-for-dot d)
  (... (dot-x d)   ;Integer
       (dot-y d))) ;Integer
;; Template rules used:
;;  - compound: 2 fields

;; ListOfDot is one of:
;;  - empty
;;  - (cons Dot ListOfDot)
;; interp. a list of Dot
(define LOD1 empty)
(define LOD2 (cons (make-dot 10 20) (cons (make-dot 3 6) empty)))
#;
(define (fn-for-lod lod)
  (cond [(empty? lod) (...)]
        [else
         (... (fn-for-dot (first lod))
              (fn-for-lod (rest lod)))]))

;; Template rules used:
;;  - one of: 2 cases
;;  - atomic distinct: empty
;;  - compound: (cons Dot ListOfDot)
;;  - reference: (first lod) is Dot
;;  - self-reference: (rest lod) is ListOfDot
```

### Guidance on Data Examples and Function Example/Tests

When writing data and function examples for self-referential data 
definitions always put the base case first. Its usually trivial for data
 examples, but many function tests don't work properly if the base case 
isn't working properly, so testing that first can help avoid being 
confused by a failure in a non base case test. Also be sure to have a 
test for a list (or other structure) that is at least 2 long.

# **How To Design Worlds (HtDW)**

World program design is divided into two phases, each of which has sub-parts:

1. Domain analysis (use a piece of paper!)
    1. Sketch program scenarios
    2. Identify constant information
    3. Identify changing information
    4. Identify big-bang options
2. Build the actual program
    1. Constants (based on 1.2 above)
    2. Data definitions using HtDD (based on 1.3 above)
    3. Functions using HtDF
        1. main first (based on 1.3, 1.4 and 2.2 above)
        2. wish list entriesfor big-bang handlers
    4. Work through wish list until done
    
    ## Phase 1: Domain Analysis
    
    Choose big-bang
    
    | If your program needs to: | Then it needs this option: |
    | --- | --- |
    | change as time goes by (nearly all do) | on-tick |
    | display something (nearly all do) | to-draw |
    | change in response to key presses | on-key |
    | change in response to mouse activity | on-mouse |
    | stop automatically | stop-when |
    
    ## **Phase 2: Building the actual program**
    
    1. Requires followed by one line summary of program's behavior
    2. Constants
    3. Data definitions
    4. Functions
    
    ## Template 1
    
    ```
    (require 2htdp/image)
    (require 2htdp/universe)
    
    ;; My world program  (make this more specific)
    
    ;; =================
    ;; Constants:
    
    ;; =================
    ;; Data definitions:
    
    ;; WS is ... (give WS a better name)
    
    ;; =================
    ;; Functions:
    
    ;; WS -> WS
    ;; start the world with ...
    ;;
    (define (main ws)
      (big-bang ws                   ; WS
                (on-tick   tock)     ; WS -> WS
                (to-draw   render)   ; WS -> Image
                (stop-when ...)      ; WS -> Boolean
                (on-mouse  ...)      ; WS Integer Integer MouseEvent -> WS
                (on-key    ...)))    ; WS KeyEvent -> WS
    
    ;; WS -> WS
    ;; produce the next ...
    ;; !!!
    (define (tock ws) ...)


    
    ;; WS -> Image
    ;; render ...
    ;; !!!
    (define (render ws) ...)
    ```
    
    ## Template 2
    
    ```
    (require 2htdp/universe)
    (require 2htdp/image)
    
    ;; A cat that walks across the screen.
    
    ;; Constants:
    
    (define WIDTH  200)
    (define HEIGHT 200)
    
    (define CAT-IMG (circle 10 "solid" "red")) ; a not very attractive cat
    
    (define MTS (empty-scene WIDTH HEIGHT))
    
    ;; Data definitions:
    
    ;; Cat is Number
    ;; interp. x coordinate of cat (in screen coordinates)
    (define C1 1)
    (define C2 30)
    
    #;
    (define (fn-for-cat c)
      (... c))
    
    ;; Functions:
    
    ;; Cat -> Cat
    ;; start the world with initial state c, for example: (main 0)
    (define (main c)
      (big-bang c                         ; Cat
                (on-tick   tock)          ; Cat -> Cat
                (to-draw   render)))      ; Cat -> Image
    
    ;; Cat -> Cat
    ;; Produce cat at next position
    ;!!!
    (define (tock c) 1)  ;stub
    
    ;; Cat -> Image
    ;; produce image with CAT-IMG placed on MTS at proper x, y position
    ; !!!
    (define (render c) MTS)
    
    ```
    
    ## Key and Mouse Handlers
    
    key
    
    ```
    (define (handle-key ws ke)
      (cond [(key=? ke " ") (... ws)]
            [else
             (... ws)]))
    ```
    
    mouse
    
    ```
    (define (handle-mouse ws x y me)
      (cond [(mouse=? me "button-down") (... ws x y)]
            [else
             (... ws x y)]))
    ```
    
