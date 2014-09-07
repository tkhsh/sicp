(load "./sec-2.5.3.scm")
(load "./ex-2.91.scm")

(define (div-poly p1 p2)
  (if (same-variable? (variable p1) (variable p2))
    (make-poly (variable p1)
               (div-terms (term-list p1)
                          (term-list p2)))
    (error "Polys not in same var -- DIV-POLY"
           (list p1 p2))))

(define (div-terms L1 L2)
  (if (empty-termlist? L1)
    (list (the-empty-termlist) (the-empty-termlist))
    (let ((t1 (first-term L1))
          (t2 (first-term L2)))
      (if (> (order t2) (order t1))
        (list (the-empty-termlist) L1)
        (let ((new-c (div (coeff t1) (coeff t2)))
              (new-o (- (order t1) (order t2))))
          (let ((rest-of-result
                  (div-terms
                    (- L1
                       (mul-terms
                         (adjoin-term (make-term new-o new-c) the-empty-termlist)
                         L2))
                    L2)))
            (let ((q (car rest-of-result))
                  (r (cadr rest-of-result)))
              (list (cons (make-term new-o new-c) q)
                    r))))))))

