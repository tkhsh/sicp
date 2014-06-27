(define (equ? x y)
  (apply-generic 'equ? x y))

(define (install-scheme-number-package)
  (put 'equ? '(scheme-number scheme-number)
       (lambda (x y) (= x y))))

(define (install-rational-package)
  (put 'equ? '(rational rational) (equal? x y)))

(define (install-complex-package)
  (put 'equ? '(complex complex)
       (lambda (x y)
         (and
           (= (real-part x) (real-part y))
           (= (imag-part x) (imag-part y))))))

