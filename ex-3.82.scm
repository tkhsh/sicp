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
    (let ((x-stream (stream-map car random-points))
          (y-stream (stream-map cadr random-points)))
      (stream-map p
                  (stream-range x-stream x1 x2)
                  (stream-range y-stream y1 y2))))
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
