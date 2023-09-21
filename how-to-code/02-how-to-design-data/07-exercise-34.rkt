;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 07-exercise-34) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; String -> String
; Design the function string-first, which extracts the first character from a non-empty string.

(check-expect (string-first "gokhan" ) "okhan")
(check-expect (string-first "hello") "ello")

;(define (string-first s) "")

;(define (string-first s)
;   (... s))

(define (string-first s)
  (substring s 1))