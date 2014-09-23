(define (make-accumulator sum)
  (lambda (x)
    (begin (set! sum (+ x sum))
           sum)))

