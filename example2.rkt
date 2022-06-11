#lang rosette
(require "myVersion1.rkt")
(require rosette/query/debug rosette/lib/render)

(define exp1 (m-if
                (m-eq (num 1) (num 0))
                (num 100)
                (plus (num 2) (num 3))
                )
  )

(repair-expr exp1 empty-env 100 list)



(define (poly x)
 (+ (* x x x x) (* 6 x x x) (* 11 x x) (* 6 x)))
 
(define/debug (fact x)
 (* x (+ x 1) (+ x 2) (+ x 2)))
 
(define (same p f x)
 (assert (= (p x) (f x))))

> (render ; visualize the result
   (debug [integer?] 
     (same poly fact -6)))