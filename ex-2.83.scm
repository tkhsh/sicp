(define (integer->rational n)
  (make-rat n 1))

(define (rational->real rat)
  (make-real (/ (numer rat) (demon rat))))

(define (real->complex x)
  (make-complex-from-real-imag x 0))

(define (raise x)
  (apply-generic 'raise x))

