(require "./stream-lib")
(require "./ex-3.59")

(define (mul-series s1 s2)
  (cons-stream (* (stream-car s1) (stream-car s2))
               (add-streams (scale-stream (stream-cdr s1) (stream-car s2))
                            (mul-series s1 (stream-cdr s2)))))

(define (main args)
  (define one-series
    (add-streams
      (mul-series sine-series sine-series)
      (mul-series cosine-series cosine-series)))
  (display-stream (stream-take one-series 10)))
