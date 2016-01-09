(load "./ex-4.51.scm")

(define (analyze exp)
  (cond ((self-evaluating? exp)
         (analyze-self-evaluating exp))
        ((quoted? exp) (analyze-quoted exp))
        ((variable? exp) (analyze-variable exp))
        ((assignment? exp) (analyze-assignment exp))
        ((permanent-assignment? exp) (analyze-permanent-assignment exp)) ; changed!
        ((definition? exp) (analyze-definition exp))
        ((if? exp) (analyze-if exp))
        ((lambda? exp) (analyze-lambda exp))
        ((begin? exp) (analyze-sequence (begin-actions exp)))
        ((if-fail? exp) (analyze-if-fail exp)) ;changed!
        ((cond? exp) (analyze (cond->if exp)))
        ((let? exp) (analyze (let->combination exp)))
        ((amb? exp) (analyze-amb exp))
        ((application? exp) (analyze-application exp))
        (else
          (error "Unknown expression type -- ANALYZE" exp))))

(define (if-fail? exp) (tagged-list? exp 'if-fail))
(define (first-exp exp) (cadr exp))
(define (second-exp exp) (caddr exp))

(define (analyze-if-fail exps)
  (let ((proc      (analyze (first-exp exps)))
        (fail-proc (analyze (second-exp exps))))
    (lambda (env succeed fail)
      (proc env
            succeed
            (lambda () (fail-proc env
                                  succeed
                                  fail))))))

(define exps
  '(
    (if-fail (let ((x (an-element-of '(1 3 5))))
               (require (even? x))
               x)
             'all-odd)
    ; => all-odd

    (if-fail (let ((x (an-element-of '(1 3 5 8))))
               (require (even? x))
               x)
             'all-odd)
    ; => 8
    )
  )
(pre-eval-driver-loop exps)
