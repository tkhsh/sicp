(load "./sec-2.5.3.scm")

(define (negate op)
  (apply-generic 'negate op))

(put 'negate '(scheme-number) -)
(put 'negate '(polynomial)
     (lambda (p)
       (make (var p)
             (negate-all-terms (term-list p)))))

(define (negate-all-terms termlist)
  (if (empty-term-list? (termlist))
    the-empty-termlist
    (let ([t1 (first-term termlist)])
      (adjoin-term
        (make-term (order t1)
                   (negate (coeff t1)))
        (negate-all-terms (rest-terms termlist))))))

(define (map-terms op termlist)
  (let ([t1 (first-term termlist)])
    (if (empty-term-list? (termlist))
      (the-empty-termlist)
      (adjoin-term
        (make-term (order t1)
                   (op (coeff t1)))
        (negate-all-terms (rest-terms termlist))))))

(define (sub-terms L1 L2)
  (add-terms L1 (negate L2)))

(define (sub-poly p1 p2)
  (if (same-variable? (variable p1) (variable p2))
    (make-poly (variable p1)
               (sub-terms (term-list p1)
                          (term-list p2)))
    (error "Polys not in same var -- ADD-POLY"
           (list p1 p2))))

(put 'sub '(polynomial polynomial)
     (lambda (p1 p2) (tag (sub-poly p1 p2))))

