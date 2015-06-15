(require "./stream-lib")
(require "./ex-3.75.scm")

(define (average v1 v2)
  (/ (+ v1 v2) 2))

(define (smooth s)
  (stream-map average s (cons-stream 0 s)))

(define sense-data
  (list->stream '(4 3 5 3 4 -1 4 3)))

(define (main args)
  (display-stream (smooth sense-data)))
