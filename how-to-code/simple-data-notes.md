# How To Design Functions (HtDF)

1. Signature, purpose and stub.
2. Define examples, wrap each in check-expect.
3. Template and inventory.
4. Code the function body.
5. Test and debug until correct

### Signature, purpose and stub
```
;; Number -> Number 
;; produce n times 2
(define (double n) 0)
```
### Define examples, wrap each in check-expect

```
;; Number -> Number 
;; produce n times 2

(check-expect (double 0) (* 0 2))
(check-expect (double 2) (* 2 2))
(check-expect (double 40) (*40 2))

(define (double n) 0)

```

### Template and inventory
```
;; Number -> Number
;; produces n times 2

(check-expect (double 0) (* 0 2))
(check-expect (double 2) (* 2 2))
(check-expect (double 40) (*40 2))

;(define (double n) 0) ; this is the stub

(define (double n)     ; this is the template
  (... n))

```


### Code the function body
```
;; Number -> Number
;; produces n times 2

(check-expect (double 0) (* 0 2))
(check-expect (double 2) (* 2 2))
(check-expect (double 40) (*40 2))

;(define (double n) 0) ; this is the stub

(define (double n)     ; this is the template
  (... n))

(define (double n)
  (* n 2))

```

### Examples for How to Design Functions -> [link](https://github.com/gokhangokcen1/ossu-journey/tree/master/how-to-code/01-how-to-design-function)

# How To Design Data (HtDD)
