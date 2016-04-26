(define (square n)
  (* n n))

(define (sum-of-squares x y)
  (+ (square x) (square y)))

(define (f x y z)
  (cond ((and (< x y) (< x z))
         (sum-of-squares y z))
        ((and (< y x) (< y z))
         (sum-of-squares x z))
        ((and (< z x) (< z y))
         (sum-of-squares x y))))

(define (main args)
  (print (f 1 2 3))
  (print (f 3 2 5))
  (print (f 3 5 0))
  )
