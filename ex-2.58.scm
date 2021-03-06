(load "./util.scm")

;; 2.58a
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
        (else
            (error "unknown expression type -- DERIV" exp))))

(define (variable? x) (symbol? x))
(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (=number? exp num)
  (and (number? exp) (= exp num)))

(define (sum? x)
  (and (pair? x) (eq? (cadr x) '+)))
(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (else (list a1 '+ a2))))
(define (addend s) (car s))
(define (augend s) (caddr s))


(define (product? x)
  (and (pair? x) (eq? (cadr x) '*)))
(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (else (list m1 '* m2))))
(define (multiplier s) (car s))
(define (multiplicand s) (caddr s))

; (print (deriv '(x * 3 * 7) 'x))
; (print (deriv '(x + 3) 'x))
; (print (deriv '(x * y) 'x))
; (print (deriv '((x * y) * (x + 3)) 'x))

;; 2.58b
(define (sum? x)
  (cond ((null? x) #f)
        ((eq? '+ (car x)) #t)
        (else (sum? (cdr x)))))

(define (addend s)
  (if (null? (cdr (addend-m s)))
      (car (addend-m s))
      (addend-m s)))
(define (addend-m s)
  (if (eq? '+ (car s))
      '()
      (cons (car s) (addend-m (cdr s)))))

(define (augend s)
  (if (null? (cdr (augend-m s)))
      (car (augend-m s))
      (augend-m s)))
(define (augend-m s)
  (if (eq? '+ (car s))
      (cdr s)
      (augend-m (cdr s))))

; (print (deriv '(3 + x) 'x))
; (print (deriv '(x * y * x) 'x))
(print (deriv '(x + 3 * (x + y + 2)) 'x))
