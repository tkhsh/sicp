(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((quoted? exp) (text-of-quotation exp))
        ((assignment? exp) (eval-assignment exp env))
        ((definition? exp) (eval-definition exp env))
        ((if? exp) (eval-if exp env))
        ((lambda? exp)
         (make-procedure (lambda-parameters exp)
                         (lambda-body exp)
                         env))
        ((begin? exp)
         (eval-sequence (begin-actions exp) env))
        ((cond? exp) (eval (cond->if exp) env))
        ((and? exp) (eval-and (and-exps exp) env))
        ; ((and? exp) (eval (and->if exp) env))
        ((or? exp) (eval-or (or-exps exp) env))
        ; ((or? exp) (eval (or->if exp) env))
        ((application? exp)
         (apply (eval (operator exp) env)
                (list-of-values (operands exp) env)))
        (else
          (error "Unknown expression type -- EVAL" exp))))

(define (and? exp) (tagged-list? exp 'and))

(define (and-exps exp) (cdr exp))

(define (eval-and exps env)
  (define (go exps env last-result)
    (if (null? exps)
      last-result
      (let ((val (eval (car exps) env)))
        (if val
          (eval-and (cdr exps) env val)
          'false))))
  (go exps env 'true))

(define (and->if exp)
  (expand-and-clauses (and-clauses exp)))

(define (and-clauses exp) (cdr exp))

(define (expand-and-clauses clauses)
  (define (go clauses last-result)
    (if (null? clauses)
      last-result
      (let ((first (car clauses))
            (rest (cdr clauses)))
        (make-if first
                 (expand-and-clauses rest)
                 'false))))
  (go clauses 'true))

(define (or? exp)
  (tagged-list? exp 'or))

(define (or-exps exp) (cdr exp))

(define (eval-or exps env)
  (define (go exps env)
    (if (null? exps)
      'false
      (let ((v (eval (car exps) env)))
        (if v
          v
          (eval-or (cdr exps) env)))))
  (go exps env))

(define (or->if exp)
  (expand-or-clauses (or-clauses exp)))

(define (or-clauses exp) (cdr exp))

(define (expand-or-clauses clauses)
  (if (null? clauses)
    'false
    (let ((first (car clauses))
          (rest (cdr clauses)))
      (make-if first
               first
               (expand-clauses-into-or rest)))))
