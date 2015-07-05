(define (expand-clauses clauses)
  (if (null? clauses)
    'false
    (let ((first (car clauses))
          (rest (cdr clauses)))
      (cond ((cond-else-clause? first)
             (if (null? rest)
               (sequence->exp (cond-actions first))
               (error "ELSE clause isn't last -- COND->IF"
                      clauses)))
            ((cond-proc-clause? first)
             (make-if (cond-predicate first)
                      ((cond-proc first) (cond-predicate first))
                      (expand-clauses rest)))
            (else (make-if (cond-predicate first)
                           (sequence->exp (cond-actions first))
                           (expand-clauses rest))))))))

(define (cond-proc-clause? clause)
  (eq? (cond-actions clause) '=>))

(define (cond-proc clause)
  (cadr clause))
