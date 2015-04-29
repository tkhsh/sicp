(require "./stream-lib")

(define (stream-limit s tolerance)
  (let ((e1 (stream-ref s 0))
        (e2 (stream-ref s 1)))
    (if (< (abs (- e1 e2)) tolerance)
      e2
      (stream-limit (stream-cdr s) tolerance))))

(define (sqrt x tolerance)
  (stream-limit (sqrt-stream x) tolerance))

(define (main args)
  (print (sqrt 10 0.001)))
