#lang racket

; QUESTION ii

(define (sum Lst)  ; procedure sum (params Lst)
     (if (null? Lst)  ; base case check if list null
         0  ; return 0
         (+ (car Lst) (sum (cdr Lst)))  ;  else do recursive case, add head of list to return of recurse on tail
         )
     )

; test cases:

; (sum '(1 2 3))
; 6

; (sum '(5))
; 5


; QUESTION iiii

(define (desc? Lst)  ; procedure desc? (params Lst)
  (if (null? (cdr Lst))  ; base case check, if list tail null
      #t  ; return true
      (if (> (car Lst) (car (cdr Lst)))  ; else do recursive case check if list head is greater than head of list tail (first value compared to next value)
          (desc? (cdr Lst))  ; recurse with tail of list
          #f  ; else return false (fail case)
          )
      )
  )

; test cases:

; (desc? '(89 78 65 45))
; #t

; (desc? '(89 45 65 79))
; #f

; (desc? '(89 78 65 65))
; #f
