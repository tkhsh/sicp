(load "./sec-4.2.3.scm")

; important!
; gosh> (car (read))
; '(a b c)
; quote
;
; gosh> (cadr (read))
; '(a b c)
; (a b c)
;
; gosh> (cadr (read))
; 'a
; a

(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((quoted? exp) (text-of-quotation exp env)) ;changed!
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
        ((application? exp)
         (apply (actual-value (operator exp) env)
                (operands exp)
                env))
        (else
          (error "Unknown expression type -- EVAL" exp))))

(define (text-of-quotation exp env)
  (let ((text (cadr exp)))
    (if (pair? text)
      (eval (literal->lazy text) env)
      text)))

(define (literal->lazy lis)
  (if (null? (cdr lis))
    (list 'cons (quote-exp (car lis)) '())
    (list 'cons (quote-exp (car lis)) (literal->lazy (cdr lis)))
    ))

(define (quote-exp exp) (list 'quote exp))

(define quoted-list
  '(
    ; '(a b c)
    ; (car '(cons 1 (cons 2 (cons 3 4))))
    (car '(a b c))
    ; 'a
    ; '(2 3)

    ; (cons 1 (cons 2 (cons 3 4)))
    (car (cons 'a (cons 'b '())))
    ; (cons 2 3)
    ))

(define (main args)
  (force-exps quoted-list)
  )
