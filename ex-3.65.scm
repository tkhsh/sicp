(require "./stream-lib")

(define (ln2 n)
  (cons-stream (/ 1.0 n)
               (stream-map - (ln2 (+ n 1)))))
(define ln2-stream
  (partial-sums (ln2 1)))

(define (main args)
  ; first
  (display-stream ln2-stream)
  ; second
  (display-stream (euler-transform ln2-stream))
  ; third
  (display-stream (accelerated-sequence euler-transform
                                        ln2-stream)))
