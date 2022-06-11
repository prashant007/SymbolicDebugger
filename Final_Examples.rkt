#lang rosette
(require "myVersion1.rkt")
(require rosette/lib/angelic    ; provides `choose*`
         rosette/lib/destruct
         racket/struct
         rosette/lib/synthax)  ; provides `destruct`
; Tell Rosette we really do want to use integers.
(current-bitwidth #f)

(define-symbolic u v w integer?)


(define myexp1 (mul (num 2)
                    (plus (num 3)
                          (num 5))))


(define myexp2 (m-let(list (cons (vvar "u") (num 2))
                           (cons (vvar "v") (num 3))
                           (cons (vvar "w") (num 5)))
                     (mul (vvar "u")
                          (plus (vvar "v")(vvar "w")))))
                                  
(define myexp (mul (num 2)(num 3)))

; repairing expressions
(repair-expr myexp empty-env 5 list)
(repair-expr myexp1 list 17 list)

(define f3 (fun-def "f3" (list "a" "b" "c") (plus
                (vvar "c")
                (mul (vvar "a")(vvar "b")))))

; repairing function f3
(repair-fun f3 (list (num 2) (num 3) (num 4)) 24 list)

(define fact (fun-def "factorial" (list "n" "m")
  (assert-exp (m-gt (vvar "m") (num 0))
     (m-if (m-eq (vvar "n") (num 1))
       (num 1)
       (plus (vvar "n") (fun-apply "factorial"
         (list (plus (vvar "n") (num -1)) 
         (plus (vvar "m") (num -1))))
       )))))

; repairing factorial program
(repair-fun fact (list (num 4) (num 30)) 24 (mk-sym-tab fact))

(define  fibo (fun-def "fibonacci" (list "n" "m")
  (assert-exp (m-gt (vvar "m") (num 0))
     (m-let (list (cons (vvar "u")
                        (fun-apply "fibonacci" (list (plus (vvar "n") (num -1))
                                                (plus (vvar "m") (num -1)))))
                  (cons (vvar "v")
                        (fun-apply "fibonacci" (list (plus (vvar "n") (num -2))
                                                (plus (vvar "m") (num -1))))))
       
       (m-if (m-eq (vvar "n") (num 1))
          (num 1)
          (m-if (m-eq (vvar "n") (num 2))
                (num 1)
                (plus (vvar "u") (vvar "v")))
          )))))


; repairing fibonacci program
;(repair-fun fibo (list (num 8) (num 30)) 21 (mk-sym-tab fibo))
