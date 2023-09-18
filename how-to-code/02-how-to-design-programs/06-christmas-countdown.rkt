;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 06-christmas-countdown) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;; Data definitions:

;; CountDown is one of:
;;  - false
;;  - Natural[1,10]
;;  - "complete"
;; interp.
;;    false           means countdown has not yet started
;;    Natural[1,10]   means countdown is running and how many seconds left
;;    "complete"      means countdown is over


#;
(define (fn-for-countdown c)
  (cond [(false? c) (...)]
        [(and (number? c) (>= 1 c) (<= c 10)) (... c)]
        [else (...)]))

;; Template rules used:
;;   - one of: 3 cases
;;   - atomic distinct: false
;;   - atomic non-distinct: Natural[1,10]
;;   - atomic distinct: "complete"

;; Functions:

;; Countdown -> Image
;; produce nice image of current state of countdown

(check-expect (countdown false) (square 0 "solid" "red"))
(check-expect (countdown 5) (text (number->string 5) 24 "black"))
(check-expect (countdown "complete") (text "Happy New Year!!!" 25 "green"))

;(define (countdown->image c) (square 0 "solid" "white")) ;stub

;<use template from Countdown>

(define (countdown c)
  (cond [(false? c)
         (square 0 "solid" "red")]
        [(and (number? c) (<= 1 c) (<= c 10))
         (text (number->string c) 24 "black")]
        [else
         (text "Happy New Year!!!" 25 "green")]))