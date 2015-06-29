(require "./stream-lib")

(define (estimated-integral-stream p x1 x2 y1 y2)
  (define (stream-range s low high)
    (stream-map (lambda (r)
                  (let ((range (- high low)))
                    (+ low (* r range))))
                s))
  (define random-points
    (map-successive-pairs (lambda (x y) (list x y))
                          random-real-numbers))
  (define experiment-stream
    (let ((x-stream (stream-range (stream-map car random-points) x1 x2))
          (y-stream (stream-range (stream-map cadr random-points) y1 y2)))
      (stream-map p x-stream y-stream)))
  (stream-map (lambda (e)
                (* (* (- x2 x1) (- y2 y1))
                   e))
              (monte-carlo experiment-stream 0 0)))

(define (main args)
  (print
    (stream-ref
      (estimated-integral-stream
        (lambda (x y) (<= (+ (* x x) (* y y)) 1.))
        -1.
        1.
        -1.
        1.)
        100000)))
