(load "./sec-4.3.scm")

(define procs
  '(
    (define (a-pythagorean-triple-between low high)
      (let ((i (an-integer-between low high)))
        (let ((j (an-integer-between i high)))
          (let ((k (an-integer-between j high)))
            (require (= (+ (* i i) (* j j)) (* k k)))
            (list i j k)))))
    ; (a-pythagorean-triple-between 1 50)

    (define (a-pythagorean-triple)
      (let ((k (an-integer-starting-from 1)))
        (let ((i (an-integer-between 1 (- k 1))))
          (let ((j (an-integer-between i (- k 1))))
          (require (= (+ (* i i) (* j j)) (* k k)))
          (list i j k)))))
    (a-pythagorean-triple)
    try-again
    try-again
    try-again
    try-again
    try-again
    try-again
    try-again
    try-again
    ; try-again
    ; ...
    )
  )

(pre-eval-driver-loop procs)
