(define (unify args)
  (let ((t1 (type-tag (car args)))
        (t2 (type-tag (cadr args)))
        (rest (cddr args))
        (a1 (car args))
        (a2 (car args))
        (t1->t2 (get-coetion t1 t2))
        (t2->t1 (get-coetion t2 t1)))
    (cond (t1->t2 (cons (t1->t2 a1)
                        (unify (cons a2 rest))))
          (t2->t1 (cons a1
                        (unify (cons(t2->t1 a2) rest))))
          (error 'error))))

; another version
(define (unify2 args)
  (define (u base-type)
    (let (cs (map (lambda (a)
                    (get-coetion (type-tag a)
                                 base-type))
                  args))
      (if (member #f cs)
        #f
        (map (lambda (c a) (c a))
             cs
             args))))
  (define (go rest)
    (if (null? rest)
      (error 'error)
      (let ((r (u (type-tag (car rest)))))
        (if r
          r
          (go (cdr rest))))))
  (go args))

(define (all-type-tags-same? args)
  (let ((t1 (type-tag (car args)))
        (t2 (type-tag (cadr args)))
        (rest (cddr args)))
    (if (null? rest)
      (equal? t1 t2)
      (and (equal? t1 t2)
         (all-type-tags-same? rest)))))

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (cond (proc
              (apply proc (map contents args)))
            ((is-all-type-tags-same args)
             (error "No method for these types"
                    (list op type-tags)))
            (else (apply-generic op (unify args)))))))

