(load "./ex-4.52.scm")

(define exps
  '(
    (let ((pairs '()))
      (if-fail (let ((p (prime-sum-pair '(1 3 5 8) '(20 35 110))))
                 (permanent-set! pairs (cons p pairs))
                 (amb))
               pairs))
    ; => ((8 35) (3 110) (3 20))
    ))
(pre-eval-driver-loop exps)
