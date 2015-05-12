(require "./stream-lib")

(define (triples s t u)
  (stream-filter (lambda (x)
                   (<= (car x) (cadr x)))
                 (stream-map (lambda (x)
                               ; (list (car x) (caadr x) (cadadr x)))
                               (cons (car x) (cadr x)))
                             (pairs s (pairs t u)))))

(define pythagoras
  (stream-filter (lambda (x)
                   (let ((i (car x))
                         (j (cadr x))
                         (k (caddr x)))
                     (= (+ (* i i) (* j j)) (* k k))))
                 (triples integers integers integers)))

(define (main args)
  (display-stream (stream-take (triples integers integers integers)
                               10))
  (print "---------------------")
  (display-stream (stream-take pythagoras 10)))
