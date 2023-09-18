;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 02-traffic-lights) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Data definitions:

;; Traffic Light (TL) Color is one of:
;;  - 0
;;  - 1
;;  - 2
;; interp. coclor of a traffic light - 0 is red, 1 yellow, 2 green
#;
(define (fn-for-tlcolor c)
   (cond [(= c 0) (...)]
	 (cond [(= c 1) (...)]
	 (cond [(= c 2) (...)]))))

;; Functions:

;; TLColor -> TLColor
;; produce next color of traffic light
(check-expect (next-color 0) 2)
(check-expect (next-color 1) 0)
(check-expect (next-color 2) 1)

;(define (next-color c) 0)    ;stub

; Template from TLColor


(define (next-color c)
	(cond [(= c 0) 2]
              [(= c 1) 0]
              [(= c 2) 1]))