; 2.73 b
(define (install-sum-package)
  (define (deriv-sum opperands var)
    (let (exp (apply make-sum opperands))
      (make-sum (deriv (addend exp) var)
                (deriv (augend exp) var))))
  (put 'deriv '+ deriv-sum))

(define (install-product-package)
  (define (deriv-product opperands var)
    (let (exp (apply make-product opperands))
      (make-sum
        (make-product (multiplier exp)
                      (deriv (multiplicand exp) var))
        (make-product (deriv (multiplier exp) var)
                      (multiplicand exp)))))
  (put 'deriv '* deriv-product))

; 2.73 c
(define (install-exp-package)
  (define (deriv-exp opperands var)
    (let (exp (apply make-exp opperands))
      (make-product
        (make-product
          (exponent exp)
          (make-exp (base exp) (- (exponent exp) 1)))
        (deriv (base exp) var))))
  (put 'derv '** deriv-exp))

