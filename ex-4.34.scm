(load "./sec-4.2.3.scm")

(define lazy-printable
  '(
    (define (cons x y)
      (lambda (m) (m lazy x y))) ; lazy が 'lazy でないことに注意!
    (define (car z)
      (z (lambda (i p q) p)))
    (define (cdr z)
      (z (lambda (i p q) q)))
    ))
(force-exps lazy-printable)

(define (lazy-pair? input)
  (cond ((not (pair? input)) #f)
        ((not (eq? (car input) 'procedure)) #f)
        (else
          (eq? 'lazy (cadar (procedure-body input))))))

(define (procedure->lambda proc)
  (make-lambda (procedure-parameters proc)
               (procedure-body proc)))

(define (print-object object)
  (define (display-delayed-cell cell)
    (if (lazy-pair? cell)
      (display "<lazy-obj>")
      (display cell)))

  (cond ((lazy-pair? object)
         (display "(")
         (display-delayed-cell (actual-value `(car ,(procedure->lambda object))
                                             (procedure-environment object)))
         (display ".")
         (display-delayed-cell (actual-value `(cdr ,(procedure->lambda object))
                                             (procedure-environment object)))
         (display ")"))
        ((compound-procedure? object)
         (display (list 'compound-procedure
                        (procedure-parameters object)
                        (procedure-body object)
                        '<procedure-env>)))
        (else (display object))))

(define test-exps
  '(cons 1 (cons 2 '())) ; -> (1 '())
  ; '(lambda (lazy) (list lazy))
  ; '(print-object (cons 1 '()))
  ; '(print-object (cons 1 (cons 2 '())))
  )

(define (user-print object)
  (print-object object)
  (newline))

(define (main args)
  (print-object (actual-value test-exps the-global-environment))
  )
