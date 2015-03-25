(require "./stream-lib")

; a
(define (integrate-series power-series-stream)
  (mul-streams power-series-stream
               (stream-map (lambda (x) (/ 1 x))
                           integers)))

; b
(define exp-series
  (cons-stream 1 (integrate-series exp-series)))
(define cosine-series
  (cons-stream 1 (scale-stream (integrate-series sine-series) -1)))

(define sine-series
  (cons-stream 0 (integrate-series cosine-series)))

(define (main args)
  (display-stream (stream-take (integrate-series (scale-stream ones 3)) 5))
  (newline)
  (display-stream (stream-take cosine-series 5))
  (newline)
  (display-stream (stream-take sine-series 6)))
