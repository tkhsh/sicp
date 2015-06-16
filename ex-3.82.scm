(require "./stream-lib")

(define (estimated-integral-stream p x1 x2 y1 y2)
  (define (random-numbers-in-range low high)
    (stream-map (lambda (r)
                  (let ((range (- high low)))
                    (+ low (* r range))))
                random-real-numbers))
  (define experiment-stream
    (if (and (= x1 y1) (= x2 y2))
      (map-successive-pairs p
                            (random-numbers-in-range x1 x2))
      (stream-map p
                 (random-numbers-in-range x1 x2)
                 (random-numbers-in-range y1 y2))))
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
