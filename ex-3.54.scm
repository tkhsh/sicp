(require "./stream-lib.scm")

(define (mul-streams s1 s2)
  (stream-map * s1 s2))

(define factorials
  (cons-stream 1 (mul-streams
                   (stream-cdr integers)
                   (stream-cdr integers))))


(define (main args)
  ; (display-stream (stream-take factorials 5))
  (display-stream (stream-take (partial-sums integers) 5))
  )
