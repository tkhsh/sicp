(load "./sec-1.1.7.scm")

(define (sqrt-iter guess x prev)
  (if (good-enough? guess prev)
    guess
    (sqrt-iter (improve guess x) x guess)))

(define (good-enough? guess prev)
  (< (/ (abs (- guess prev)) guess) 0.001))

(define (sqrt x)
  (sqrt-iter 1.0 x +inf.0))

(define (main args)
  ; (print (sqrt 0.0002))
  )

