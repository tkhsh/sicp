(require "./stream-lib")
(require "./ex-3.77.scm")

(define (solve-2nd f dt y0 dy0)
  (define y (integral (delay dy) y0 dt))
  (define dy (integral (delay ddy) dy0 dt))
  (define ddy (stream-map f dy y))
  y)

(define (main args)
  (print (stream-ref (solve-2nd (lambda (dy y) (+ (* 3 dy) (* 5 y)))
                                0.001
                                8
                                10)
                     1000)))
