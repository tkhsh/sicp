(load "./sec-2.3.2.scm")

(define (deriv exp var)
    (cond ((number? exp) 0)
        ((variable? exp)
            (if (same-variable? exp var) 1 0))
        ((sum? exp)
            (make-sum (deriv (addend exp) var)
                      (deriv (augend exp) var)))
        ((product? exp)
            (make-sum
                (make-product (multiplier exp)
                              (deriv (multiplicand exp) var))
                (make-product (deriv (multiplier exp) var)
                              (multiplicand exp))))
        ((exponentiation? exp)
            (make-product (make-product (exponent exp)
                                        (make-exponentiation (base exp)
                                                             (- (exponent exp) 1)))
                          (deriv (base exp) var)))
        (else
            (error "unknown expression type -- DERIV" exp))))

(define (exponentiation? e)
  (and (pair? e) (eq? (car e) '**)))

(define (base e) (cadr e))
(define (exponent e) (caddr e))

(define (make-exponentiation m1 m2)
  (list '** m1 m2))
; (print (deriv '(** x 3) 'x))

(define (make-exponentiation m1 m2)
  (cond ((=number? m2 0) 1)
        ((number? m2) (make-product m1 (make-exponentiation m1 (- m2 1))))
        (else (list '** m1 m2))))
; (print (deriv '(** x 4) 'x))
