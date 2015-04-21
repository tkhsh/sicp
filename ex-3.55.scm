(require "./stream-lib.scm")

(define (partial-sums stream)
  (define p-sums
    (cons-stream (stream-car stream)
                 (add-streams (stream-cdr stream)
                              p-sums)))
  p-sums)

(define (main args)
  (display-stream (stream-take (partial-sums integers) 5000)))
