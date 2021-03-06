(require "./stream-lib")

(define (pairs-supplement s t)
  (cons-stream
    (list (stream-car s) (stream-car t))
    (interleave
      (stream-map (lambda (x) (list x (stream-car t)))
                  (stream-cdr s))
      (pairs-supplement (stream-cdr s) (stream-cdr t)))))

(define (pairs-whole s t)
  (interleave (pairs s t)
              (pairs-supplement (stream-cdr s) t)))

(define (main args)
  (display-stream (stream-take (pairs-whole integers integers)
                               30))
  (print "------------------------")
  (display-stream (stream-take (pairs-supplement integers integers)
                               10))
  (print "------------------------")
  (display-stream (stream-take (pairs integers integers)
                               10)))
