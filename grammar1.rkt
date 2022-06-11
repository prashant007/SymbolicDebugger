;#lang plai
#lang rosette


(require rosette/lib/angelic    ; provides `choose*`
         rosette/lib/destruct
         racket/struct
         rosette/lib/synthax)  ; provides `destruct`
; Tell Rosette we really do want to use integers.
(current-bitwidth #f)

(define-symbolic x y m integer?)

(current-grammar-depth 2) ; Set the grammar depth.

; Syntax for our simple DSL
(struct plus (left right) #:transparent)
(struct mul (left right) #:transparent)
(struct num (arg) #:transparent)
(struct square (arg) #:transparent)

(define-grammar (expr?? x y)
  [expr                
   (choose x y (?? integer?) ((binop) (expr) (expr)) ((unop)(expr)))] 
  [unop                             
   (choose num square)]  
  [binop                            
   (choose plus mul)])  

; Interpreter for our DSL.
; We just recurse on the program's syntax using pattern matching.
(define (interpret p)
  (destruct p
            [(plus a b)  (+ (interpret a) (interpret b))]
            [(num a)     a]
            [(mul a b)   (* (interpret a) (interpret b))]
            [(square a)  (expt (interpret a) 2)]
            [_ p]))


(define (some-fun a b) (plus (plus a (mul (num 2) b)) (mul (num 1) a)))


(define (new-fun x y)
  (expr?? x y #:depth 1))


(define sol
  (synthesize
   #:forall (list x y)
   #:guarantee  (begin (assume (and (> x 0) (> y 0)))
                       (assert (equal? (interpret(some-fun x y)) (interpret(new-fun x y)))))
                       ;(assert (equal? (interpret(some-fun 5 10)) 30)))
                       )
   )
  

;(interpret (some-fun x y))
;(interpret (new-fun x y))
(print-forms sol)
;(define sketch1 (??expr (s-add 2 3)))


;(define ans1 (evaluate sketch1 sol))


;(define (expr1 x)
;  (arith-exprs x))

;(expr1 (num 3))