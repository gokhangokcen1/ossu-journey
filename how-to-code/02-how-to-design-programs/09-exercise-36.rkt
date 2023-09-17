;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 09-exercise-36) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
; Image -> Number
; design the function image-area, which counts the number of pixels sin a given image


(check-expect (image-area (rectangle 5 10 "solid" "red")) 50)
(check-expect (image-area (rectangle 20 2 "solid" "red")) 40)
(check-expect (image-area (rectangle 100 100 "solid" "red")) 10000)

;(define (image-area img) 0)

;(define (image-area img)
;   (... img))

(define (image-area img)
  (* (image-height img) (image-width img)))