(define (pascal-triangle x y)
  (if (edge? x y)
    1
    (+ (pascal-triangle (- x 1) (- y 1))
       (pascal-triangle (- x 1) y))))

(define (edge? x y)
  (cond ((= x y) #t)
        ((= 1 y) #t)
        (else #f)))

(define (main args)
  ; (print (pascal-triangle 1000 1))
  (print (pascal-triangle 3 2))
  (print (pascal-triangle 4 3))
  (print (pascal-triangle 5 4))
  (print (pascal-triangle 5 3))
  )
