(define (recursive-f n)
  (if (< n 3)
    n
    (+ (recursive-f (- n 1))
       (* 2 (recursive-f (- n 2)))
       (* 3 (recursive-f (- n 3))))))

(define (iterative-f n)
  (f-iter 2 1 0 n n))
(define (f-iter v1 v2 v3 acc count)
  (if (< count 3)
    acc
    (f-iter (+ v1 (* 2 v2) (* 3 v3))
            v1
            v2
            (+ v1 (* 2 v2) (* 3 v3))
            (- count 1))))

(define (main args)
  (print (recursive-f 3))
  (print (iterative-f 3))

  (print (recursive-f 5))
  (print (iterative-f 5))
  )
