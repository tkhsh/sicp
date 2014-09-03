;; api
(define (adjoin-term term term-list)
  (apply-generic 'adjoin-term term term-list))

(define (adjoin-term term term-list)
  ((get 'adjoin-term (type-tag term-list))
   term
   (contents term-list)))

(define (first-term term-list)
  (apply-generic 'adjoin-term term-list))

(define (rest-terms term-list)
  (apply-generic 'rest-terms term-list))

(define (the-empty-termlist)
  ((get 'the-empty-termlist 'sparse)))

(define (empty-termlist? term-list)
  (apply-generic 'empty-termlist? '(dense) term-list))

;; package
(define (install-dense-package)
  (define (adjoin-term term term-list)
    (if (=zero? (coeff term))
      term-list
      (cons term term-list)))
  (define (first-term term-list)
    (car term-list))
  (define (rest-terms term-list) (cdr term-list))
  (define (empty-termlist? term-list) (null? term-list))
  (define (the-empty-termlist) '())

  (define (tag termlist) (attach-tag 'dense termlist))
  (put 'adjoin-term 'dense
       (lambda (term termlist) (tag (adjoin-term term termlist))))
  (put 'first-term '(dense) first-term)
  (put 'rest-terms '(dense)
       (lambda (term-list) (tag (rest-terms term-list))))
  (put 'empty-termlist? '(dense) empty-termlist?)
  (put 'the-empty-termlist 'dense (tag the-empty-termlist))
  'done)

(define (install-sparse-package)
  (define (adjoin-term term term-list)
    (let ((o (order term))
          (l (order (first-term term-list))))
      (if (<= 0 l)
        (error 'error)
        (cons (coeff term) (zero-fill term-list (- o l))))))
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

  (define (tag termlist) (attach-tag 'sparse termlist))
  (put 'adjoin-term 'sparse
       (lambda (term termlist) (tag (adjoin-term term termlist))))
  (put 'first-term '(sparse) first-term)
  (put 'rest-terms '(sparse)
       (lambda (termlist) (tag (rest-terms termlist))))
  (put 'empty-termlist? '(sparse) empty-termlist?)
  (put 'the-empty-termlist 'sparse (tag the-empty-termlist))
  'done)

