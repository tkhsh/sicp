(require "./stream-lib")
(require "./ex-3.74")

(define (make-zero-crossings input-stream last-value last-avpt)
  (let ((avpt (/ (+ (stream-car input-stream) last-value) 2)))
    (cons-stream (sign-change-detector avpt last-avpt)
                 (make-zero-crossings (stream-cdr input-stream)
                                      (stream-car input-stream)
                                      avpt))))

(define sense-data
  (list->stream '(4 3 -10 3 4 -1 -1 3)))

(define (main args)
  (display-stream (stream-take (make-zero-crossings sense-data 0 0)
                               8)))
