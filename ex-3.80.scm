(require "./stream-lib")
(require "./ex-3.77.scm")

(define (RLC R L C dt)
  (lambda (vC0 iL0)
    (define iL (integral (delay diL) iL0 dt))
    (define vC (integral (delay dvC) vC0 dt))
    (define dvC (scale-stream iL (/ -1 C)))
    (define diL (add-streams (scale-stream iL (/ (- R) L))
                             (scale-stream vC (/ 1 L))))
    (cons iL vC)))

(define (main args)
  (define answer ((RLC 1 1 0.2 0.1) 10 0))
  (print (stream-ref (car answer) 1000))
  (print (stream-ref (cdr answer) 1000)))