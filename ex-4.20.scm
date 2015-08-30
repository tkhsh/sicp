(require "./evaluator.scm")

(define (letrec? exp)
  (tagged-list? exp 'letrec))

(define (letrec-bindings exp) (cadr exp))

(define (letrec-body exp) (cddr exp))

(define (letrec->let-combination exp)
  (define (make-unassigned-bindings variables)
    (map (lambda (v) (list v ''*unassigned*))
         variables))
  (define (set-bindings variables values)
    (map (lambda (var val) (make-assignment var val))
         variables
         values))
  (let* ((bindings (letrec-bindings exp))
         (variables (map car bindings))
         (values (map cadr bindings)))
    `(let ,(make-unassigned-bindings variables)
       ,@(set-bindings variables values)
       ,@(letrec-body exp))))

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
        ((let? exp) (eval (let->combination exp) env))
        ((letrec? exp) (eval (letrec->let-combination exp) env)) ;; Changed!!
        ((application? exp)
         (apply (eval (operator exp) env)
                (list-of-values (operands exp) env)))
        (else
          (error "Unknown expression type -- EVAL" exp))))

(define (main args)
  (print (eval '(letrec ((fact
                          (lambda (n)
                            (if (= n 1)
                              1
                              (* n (fact (- n 1)))))))
                 (fact 10))
               the-global-environment))

  (print (letrec ((fact
                    (lambda (n)
                      (if (= n 1)
                        1
                        (* n (fact (- n 1)))))))
           (fact 10)))
  )
