(load "./sec-2.5.3.scm")

(define (=zero? term)
  (apply-generic '=zero? term))

(put '=zero? '(scheme-number)
     (lambda (x)
       (= x 0)))

(put '=zero? '(polynomial)
     (lambda (x)
       (empty-term-list? (term-list x))))

