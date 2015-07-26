; 1.2.2
(define (fib n)
  (define (fib-iter a b count)
    (if (= count 0)
      b
      (fib-iter (+ a b) a (- count 1))))
  (fib-iter 1 0 n))

; (define (fib-iter a b count)
;   (if (= count 0)
;       b
;       (fib-iter (+ a b) a (- count 1))))

; 4.8
(define (fib n)
  (let fib-iter ((a 1)
                 (b 0)
                 (count n))
    (if (= count 0)
        b
        (fib-iter (+ a b) a (- count 1)))))

; (let var ((var1 exp1)
;           (var2 exp2)
;           ...
;           (varN expN))
;   body)

; (define (var var1 var2 ... varN)
;   body)
; (var exp1 exp2 ... expN)
;
; (let ((var nil))
;   (set! var (lambda (var1 var2 ... varN) body))
;   (var exp1 exp2 ... expN))

; (letrec ((var (lambda (var1 var2 ... varN) body)))
;   (var exp1 exp2 ... expN))

(define (named-let-bindings exp)
  (caddr exp))

(define (named-let-name exp)
  (cadr exp))

(define (named-let-body exp)
  (cdddr exp))
; TODO 場合分けで実装する方法も試す
; (define (let-bindings exp) (cadr exp))

(define (make-assignment var val)
  (list 'set! var val))

(define (plain-let? exp)
  (list? (cadr exp)))

(define (let->combination exp)
  (if (plain-let? exp)
    (plain-let->combination exp)
    (named-let->combination exp)))

(define (plain-let->combination exp)
  (let* ((bindings (let-bindings exp))
         (vars (map car bindings))
         (val-exps (map cadr bindings)))
    (cons (make-lambda vars (let-body exp))
          val-exps)))

(define (named-let->combination exp)
  (let* ((name (named-let-name exp))
         (bindings (named-let-bindings exp))
         (vars (map car bindings))
         (val-exps (map cadr bindings)))
    (make-let (list (list name 'nil))
              (list (make-assignment name
                                     (make-lambda vars (named-let-body exp)))
                    (make-application name val-exps)))))
