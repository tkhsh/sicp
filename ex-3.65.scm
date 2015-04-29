(require "./stream-lib")

(define (ln2 n)
  (cons-stream (/ 1.0 n)
               (stream-map - (ln2 (+ n 1)))))
(define ln2-stream
  (partial-sums (ln2 1)))

(define (main args)
  ; first
  (print "--------first-------")
  (display-stream (stream-take ln2-stream 10))
  ; second
  (print "--------second------")
  (display-stream (stream-take (euler-transform ln2-stream)
                               10))
  ; third
  (print "--------third-------")
  (display-stream (stream-take (accelerated-sequence euler-transform
                                         ln2-stream)
                               10)))
