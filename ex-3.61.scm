(require "./stream-lib")
(require "./ex-3.59")
(require "./ex-3.60")

(define (invert-unit-series s)
  (define x
    (cons-stream 1
                 (scale-stream (mul-series (stream-cdr s)
                                           x)
                               -1)))
  x)

(define (main args)
  (display-stream (stream-take (mul-series exp-series
                                           (invert-unit-series exp-series))
                               100)))
