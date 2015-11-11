(load "./sec-4.3.scm")

(define exps
  '(
    (define (distinct? items)
      (cond ((null? items) true)
            ((null? (cdr items)) true)
            ((member (car items) (cdr items)) false)
            (else (distinct? (cdr items)))))

    (define (xor b1 b2)
      (if b1
        (if b2 false true)
        (if b2 true false)))

    (define (liars-puzzle)
      (let ((betty (amb 1 2 3 4 5))
            (ethel (amb 1 2 3 4 5))
            (joan  (amb 1 2 3 4 5))
            (kitty (amb 1 2 3 4 5))
            (mary  (amb 1 2 3 4 5)))
        (require (xor (= kitty 2) (= betty 3)))
        (require (xor (= ethel 1) (= joan 2)))
        (require (xor (= joan 3) (= ethel 5)))
        (require (xor (= kitty 2) (= mary 4)))
        (require (xor (= mary 4) (= betty 1)))
        (require
          (distinct? (list betty ethel joan kitty mary)))
        (list (list 'betty betty)
              (list 'ethel ethel)
              (list 'joan joan)
              (list 'kitty kitty)
              (list 'mary mary))))
    (liars-puzzle)
   )
  )
(pre-eval-driver-loop exps)

