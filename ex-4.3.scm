; envに型をつける必要がある。
; number?とかばデータ主導につかえないのはなんでだったか？ cf. 2.73 a

; sec-2.4.3
(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (error
            "No method for these types -- APPLY-GENERIC"
            (list op type-tags))))))

; envがいらない場合も受け取るようにしないといけなくなった...
(define (install-self-evaluating-package)
  (define (eval-self-evaluating exp env)
    exp)
  (put 'eval '(self-evaluating env) eval-self-evaluating))

(define (install-variable-package)
  (define (eval-variable exp env)
    (lookup-variable-value exp env))
  (put 'eval '(variable env) eval-variable))

(define (install-quote-package)
  (define (eval-quote exp env)
    (text-of-quotation exp))
  (put 'eval '(quote env) eval-quote))

(define (install-assignment-package)
  (put 'eval '(assignment env) eval-assignment))

(define (install-definition-package)
  (put 'eval '(definition env) eval-definition))

(define (install-if-package)
  (put 'eval '(if env) eval-if))

(define (install-lambda-package)
  (define (eval-lambda exp env)
    (make-procedure (lambda-parameters exp)
                    (lambda-body exp)
                    env))
  (put 'eval '(lambda env) eval-lambda))

(define (install-begin-package)
  (define (eval-begin exp env)
    (eval-sequence (begin-actions exp) env))
  (put 'eval '(begin env) eval-begin))

(define (install-cond-package)
  (define (eval-cond exp env)
    (eval (cond->if exp) env))
  (put 'eval '(begin env) eval-cond))

(define (install-application-package)
  (define (eval-application exp env)
    (apply (eval (operator exp) env)
           (list-of-values (operands exp) env)))
  (put 'eval '(application env) eval-application))

(define (eval exp env)
  (apply-generic 'eval (list exp env)))
