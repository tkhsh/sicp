(load "./sec-4.3.scm")

(define (permanent-assignment? exp) (tagged-list? exp 'permanent-set!))

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
        ((cond? exp) (analyze (cond->if exp)))
        ((let? exp) (analyze (let->combination exp)))
        ((amb? exp) (analyze-amb exp))
        ((application? exp) (analyze-application exp))
        (else
          (error "Unknown expression type -- ANALYZE" exp))))

(define (analyze-permanent-assignment exp)
  (let ((var (assignment-variable exp))
        (vproc (analyze (assignment-value exp))))
    (lambda (env succeed fail)
      (vproc env
             (lambda (val fail2)
                 (set-variable-value! var val env)
                 (succeed 'ok fail2))
             fail))))

(define exps
  '(
    (define count 0)
    (let ((x (an-element-of '(a b c)))
          (y (an-element-of '(a b c))))
      (set! count (+ count 1))
      (require (not (eq? x y)))
      (list x y count))
    ;;; Starting a new problem
    ;;; Amb-Eval value:
    ; (a b 2)
    ;;; Amb-Eval input:
    ; try-again
    ;;; Amb-Eval value:
    ; (a c 3)
    )
  )
; (pre-eval-driver-loop exps)

; permanent-set!ではなくset!を使用した場合は
; それぞれ以下のように表示される。
; (a b 2) -> (a b 1)
; (a c 3) -> (a c 1)
