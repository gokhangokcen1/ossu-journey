;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 08-exercise-35) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; String->String
; design the function string-last, which extracts the last character from a non-empty string

(check-expect (string-last "gokhan") "gokha")
(check-expect (string-last "goethe") "goeth")

;(define (string-last s ) "")

;(define (string-last s)
;   (... s))


(define (string-last s)
  (substring s 0 (- (string-length s) 1)))