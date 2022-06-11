Various examples shown in the paper are present in the file Final_Examples.rkt. The main code for the project is present in myVersion1.rkt. In order to  run the examples shown in the paper, put both the files in a folder and navgiate to that folder on the command line. 

Then to run various repairs, execute the file as shown below. Ofcourse, this  assumes that Racket as  well as the Rosette library is installed on the machine.

C:\Users\prash\Desktop\MiscDesktop\SMT\CS517_Project>racket Final_Examples.rkt
(plus (num 2) (num 3))
(plus (num 2) (mul (num 3) (num 5)))
(fun-def "f3" '("a" "b" "c") (mul (vvar "c") (mul (vvar "a") (vvar "b"))))
(fun-def "factorial" '("n" "m") (assert-exp (m-gt (vvar "m") (num 0)) (m-if (m-eq (vvar "n") (num 1)) (num 1) (mul (vvar "n") (fun-apply "factorial" (list (plus (vvar "n") (num -1)) (plus (vvar "m") (num -1))))))))