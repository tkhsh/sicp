(load "./sec-4.3.scm")

(define procs
  '(
    (define (require p) (if (not p) (amb)))
    (define (an-element-of items)
      (require (not (null? items)))
      (amb (car items) (an-element-of (cdr items))))
    (define (an-integer-starting-from n)
      (amb n (an-integer-starting-from (+ n 1))))

    (define (an-integer-between min max)
      (require (< min (+ 1 max)))
      (amb min (an-integer-between (+ min 1) max)))
    ; (an-integer-between 1 3)
    ; try-again
    ; try-again

    (define (a-pythagorean-triple-between low high)
      (let ((i (an-integer-between low high)))
        (let ((j (an-integer-between i high)))
          (let ((k (an-integer-between j high)))
            (require (= (+ (* i i) (* j j)) (* k k)))
            (list i j k)))))
    (a-pythagorean-triple-between 1 50)
    )
  )

; (pre-eval-driver-loop procs)
