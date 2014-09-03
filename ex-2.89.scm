(load "./sec-2.5.3.scm")

(define (adjoin-term term term-list)
  (if (=zero? (coeff term))
      term-list
      (cons term term-list)))

(define (adjoin-term term term-list)
  (cond ((=zero? (coeff term)) term-list)
        ((=< (order term)
             (order (first-term term-list)))
         (error 'error))
        ((> (order term) (first-term term-list))
         (a-term term term-list (order (first-term term-list))))))

(define (a-term term term-list max-order)
  (if (= (order term) max-order)
    (cons (coeff term) term-list)
    (a-term
      term
      (cons 0 term-list)
      (+ max-order 1))))

(define (adjoin-term term term-list)
  (let ((o (order term))
        (ol (order (first-term term-list))))
    (if (<= 0 ol)
      (error 'error)
      (cons (coeff term) (zero-fill term-list (- o ol))))))
(define (zero-fill term-list n)
  (if (= 0 n)
    term-list
    (zero-fill (cons 0 term-list) (- n 1))))

(define (the-empty-termlist) '())
(define (first-term term-list)
  (make-term
    (- (length term-list) 1)
       (car term-list)))
(define (rest-terms term-list) (cdr term-list))
(define (empty-termlist? term-list) (null? term-list))


