(define (install-self-evaluating-package)
  (define (eval-self-evaluating exp env)
    exp)
  (put 'eval 'self-evaluating eval-self-evaluating))

(define (install-variable-package)
  (define (eval-variable exp env)
    (lookup-variable-value exp env))
  (put 'eval 'variable eval-variable))

(define (install-quote-package)
  (define (eval-quote exp env)
    (text-of-quotation exp))
  (put 'eval 'quote eval-quote))

(define (install-assignment-package)
  (put 'eval 'assignment eval-assignment))

(define (install-definition-package)
  (put 'eval 'definition eval-definition))

(define (install-if-package)
  (put 'eval 'if eval-if))

(define (install-lambda-package)
  (define (eval-lambda exp env)
    (make-procedure (lambda-parameters exp)
                    (lambda-body exp)
                    env))
  (put 'eval 'lambda eval-lambda))

(define (install-begin-package)
  (define (eval-begin exp env)
    (eval-sequence (begin-actions exp) env))
  (put 'eval 'begin eval-begin))

(define (install-cond-package)
  (define (eval-cond exp env)
    (eval (cond->if exp) env))
  (put 'eval 'cond eval-cond))

(define (install-application-package)
  (define (eval-application exp env)
    (apply (eval (operator exp) env)
           (list-of-values (operands exp) env)))
  (put 'eval 'application eval-application))

(define (eval exp env)
  (let ((exp-type (type-tag exp)))
    (let ((proc (get 'eval exp-type)))
      (if proc
          (proc exp env)
          (error
            "No method for this type -- EVAL"
            exp-type)))))
; TODO (type-tag exp)を実装する必要がある。
; データにはタグが必ずついているとは限らないので元々のevalみたいな式の判別処理をする必要がある。
; ex-2.73のデータ主導版derivは振り分けと処理が分離できていないので中途半端
