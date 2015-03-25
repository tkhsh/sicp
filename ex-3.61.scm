(require "./stream-lib")
(require "./ex-3.59")
(require "./ex-3.60")

(define (invert-unit-series s)
  (cons-stream 1
               (scale-stream (mul-series (stream-cdr s)
                                         (invert-unit-series s))
                             -1)))

(define (main args)
  (display-stream (stream-take (mul-series exp-series
                                           (invert-unit-series exp-series))
                               5)))
