(load "./sec-2.5.3.scm")
(load "./ex-2.84.scm")
(load "./ex-2.85.scm")

(define (variable<? v1 v2)
  (string<?
    (symbol->string v1)
    (symbol->string v2)))

(define (add-poly p1 p2)
  (let ((v1 (variable p1))
        (v2 (variable p2)))
    (if (same-variable? v1 v2)
      (make-poly v1
                 (add-terms (term-list p1)
                            (term-list p2)))
      (if (variable<? v1 v2)
        (add-poly
          p1
          (yomikae p2 v1))
        (add-poly
          (yomikae p1 v2)
          p2)))))

(define (yomikae p v)
  (make-poly v
             (adjoin-term
               (make-term 0 p)
               (the-empty-termlist))))

(put 'supertype 'complex 'poly)
(put 'raise '(complex) (lambda (z) (yomikae z 'x)))
(put 'project '(poly) (lambda (p) (coeff (first-term (term-list p)))))

(define (mul-poly p1 p2)
  (let ((v1 (variable p1))
        (v2 (variable p2)))
    (if (same-variable? v1 v2)
      (make-poly v1
                 (mul-terms (term-list p1)
                            (term-list p2)))
      (if (variable<? v1 v2)
        (mul-poly
          p1
          (yomikae p2 v1))
        (mul-poly
          (yomikae p1 v2)
          p2)))))

