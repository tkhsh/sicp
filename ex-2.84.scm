(define (raise x)
  (apply-generic 'raise x))

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
        (apply proc (map contents args))
        (apply-generic
          op
          (apply raise-args-one-step args))))))

(define (raise-args-one-step args)
  (define types (map type-tag args))
  (define (loop rest)
    (if (null? rest)
      (error 'errorhappen)
      (let ([a (car rest)]
            [t1 (type-tag a1)])
        (if (lowest-tyes? t1 types)
          (cons (raise a1) (cdr rest))
          (cons a1 (loop (cdr rest)))))))
  (loop args))

(define (lowest-type? t1 types)
  (every
    (lambda (t)
      (type<= t1 t))
    types))

(define (type<= t1 t2)
  (member? t2 (supertypes t1)))

(define (supertypes t)
  (let ((stype (supertype t)))
    (if stype
      (cons stype (supertypes stype))
      '())))

(define (supertype t)
  (get 'supertype t))
(put 'supertype 'integer 'rational)
(put 'supertype 'rational 'real)
(put 'supertype ' real 'complex)

