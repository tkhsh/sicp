(define (sine x)
  (apply-generic 'sine x))

(put 'sine '(complex)
     (lambda (x)
       (if (valid-angle? (angle x))
         (apply-generic 'sine (angle x))
         (error "Invalid datum"))))
(put 'sine '(real) sin)

(define (cosine x)
  (apply-generic 'cosine x))

(put 'cosine '(comple)
     (lambda (x)
       (if (valid-angle? (angle x))
         (apply-generic 'cosine (angle x))
         (error "Invalid datum"))))
(put 'cosine '(real) cos)

(define (valid-angle? x)
  (if (eq? 'complex (type-tag x))
    #f
    #t))

