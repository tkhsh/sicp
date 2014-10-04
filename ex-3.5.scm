(use srfi-27)
(random-source-randomize! default-random-source)

(define (random r)
  (* (random-real) r))

; (print (random 100))
; (print (random 100))
; (print (random 100))
; (print (random 100))
; (print (random 100))

(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (random range))))

;(print (random-in-range 10 30))
;(print (random-in-range 10 30))
;(print (random-in-range 10 30))
;(print (random-in-range 10 30))
;(print (random-in-range 10 30))

(define (monte-carlo trials experiment)
  (define (iter trials-remaining trials-passed)
    (cond ((= trials-remaining 0)
           (/ trials-passed trials))
          ((experiment)
           (iter (- trials-remaining 1) (+ trials-passed 1)))
          (else
           (iter (- trials-remaining 1) trials-passed))))
  (iter trials 0))

(define (estimate-integral p x1 x2 y1 y2 trials)
  (* (* (- x2 x1) (- y2 y1))
     (monte-carlo
       trials
       (lambda ()
         (p (random-in-range x1 x2) (random-in-range y1 y2))))))

(print (estimate-integral
         (lambda (x y) (<= (+ (* x x) (* y y)) 1.))
         -1.
         1.
         -1.
         1.
         1000000))

