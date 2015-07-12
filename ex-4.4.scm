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
        ; ((and? exp) (eval-and (and-exps exp) env))
        ((and? exp) (eval (and->if exp) env))
        ; ((or? exp) (eval-or (or-exps exp) env))
        ((or? exp) (eval (or->if exp) env))
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
        (if (true? val)
          (go (cdr exps) env val)
          'false))))
  (go exps env 'true))

(define (and->if exp)
  (expand-and-exps (and-exps exp)))

(define (expand-and-exps exps)
  (if (null? exps)
    'true
    (let ((first (car exps))
          (rest (cdr exps)))
      (if (null? rest)
        first
        (make-if first
                 (expand-and-exps rest)
                 'false)))))

(define (or? exp)
  (tagged-list? exp 'or))

(define (or-exps exp) (cdr exp))

(define (eval-or exps env)
  (define (go exps env)
    (if (null? exps)
      'false
      (let ((val (eval (car exps) env)))
        (if (true? val)
          val
          (go (cdr exps) env)))))
  (go exps env))

(define (or->if exp)
  (expand-or-exps (or-exps exp)))

(define (expand-or-exps exps)
  (if (null? exps)
    'false
    (let ((first (car exps))
          (rest (cdr exps)))
      (make-let (list (list 'f first)) ;TOFIX ユーザーが定義した変数名と衝突するバグがある
                (list (make-if 'f
                               'f
                               (expand-or-exps rest)))))))
