(load "./sec-4.3.scm")
(use srfi-27)

(random-source-randomize! default-random-source)

(define (ramb? exp) (tagged-list? exp 'ramb))
(define (ramb-choices exp) (cdr exp))

(define (analyze exp)
  (cond ((self-evaluating? exp)
         (analyze-self-evaluating exp))
        ((quoted? exp) (analyze-quoted exp))
        ((variable? exp) (analyze-variable exp))
        ((assignment? exp) (analyze-assignment exp))
        ((definition? exp) (analyze-definition exp))
        ((if? exp) (analyze-if exp))
        ((lambda? exp) (analyze-lambda exp))
        ((begin? exp) (analyze-sequence (begin-actions exp)))
        ((cond? exp) (analyze (cond->if exp)))
        ((let? exp) (analyze (let->combination exp)))
        ((amb? exp) (analyze-amb exp))
        ((ramb? exp) (analyze-ramb exp)) ;; changed
        ((application? exp) (analyze-application exp))
        (else
          (error "Unknown expression type -- ANALYZE" exp))))

(define (remove-at lst n)
  (if (= n 0)
    (cdr lst)
    (cons (car lst)
          (remove-at (cdr lst) (- n 1)))))

(define (analyze-ramb exp)
  (let ((cprocs (map analyze (ramb-choices exp))))
    (lambda (env succeed fail)
      (define (try-random choices)
        (if (null? choices)
          (fail)
          (let ((rand-index (random-integer (length choices))))
            (let ((choice (list-ref choices rand-index))
                  (rest   (remove-at choices rand-index)))
              (choice env
                      succeed
                      (lambda () (try-random rest)))))))
      (try-random cprocs))))

; (define exps
;   '(
;     (ramb 1 2 3 4)
;     try-again
;     try-again
;     try-again
;     ))
; (pre-eval-driver-loop exps)
