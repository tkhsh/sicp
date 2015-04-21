(require "./stream-lib.scm")

; ただし、この実装は効率が悪い
(define (partial-sums stream)
  (cons-stream (stream-car stream)
               (add-streams (stream-cdr stream)
                            (partial-sums stream))))

(define (main args)
  (display-stream (stream-take (partial-sums integers) 5000)))
