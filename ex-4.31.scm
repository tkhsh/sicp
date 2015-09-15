(load "./sec-4.2.2.scm")
; (define a (plus 1))
; (define (f x y) (+ x y))
; (define (f a (b lazy) c (d lazy-memo)) (+ x y))

(define (apply procedure arguments env)
  (cond ((primitive-procedure? procedure)
         (apply-primitive-procedure
          procedure
          (list-of-arg-values arguments env)))
        ((compound-procedure? procedure) ;procedureが'(procedure (a (b lazy) c (d lazy-memo)) body)
         (eval-sequence
          (procedure-body procedure)
          (extend-environment
           (map (lambda (p) (if (lazy? p) (car p) p)) (procedure-parameters procedure)) ; Changed
           (list-of-args (procedure-parameters procedure) arguments env)   ; Changed!
           (procedure-environment procedure))))
        (else
         (error
          "Unknown procedure type -- APPLY" procedure))))

(define (list-of-args parameters arguments env)
  (define (go params args env)
    (if (null? params)
      '()
      (let ((first-p (car params)))
        (if (lazy? first-p)
          (cond ((eq? (cadr first-p) 'lazy)
                 (cons (delay-it (first-operand args) env)
                       (go (cdr params) (cdr args) env)))
                ((eq? (cadr first-p) 'lazy-memo)
                 (cons (delay-it-memo (first-operand args) env)
                       (go (cdr params) (cdr args) env)))
                (else
                  (error "Unknown parameter type -- LIST-OF-ARGS" first-p)))
          (cons (actual-value (first-operand args) env)
                (go (cdr params) (cdr args) env))))))
  (if (= (length parameters) (length arguments))
    (go parameters arguments env)
    (if (< (length vars) (length vals))
      (error "Too many arguments supplied" vars vals)
      (error "Too few arguments supplied" vars vals))))

(define (lazy? parameter)
  (pair? parameter))

(define (force-it obj)
  (cond ((thunk? obj)
         (actual-value (thunk-exp obj) (thunk-env obj)))
        ((memo-thunk? obj)
         (let ((result (actual-value
                         (thunk-exp obj)
                         (thunk-env obj))))
           (set-car! obj 'evaluated-thunk)
           (set-car! (cdr obj) result)
           (set-cdr! (cdr obj) '())
           result))
        ((evaluated-thunk? obj)
         (thunk-value obj))
        (else obj)))

(define (delay-it-memo exp env)
  (list 'memo-thunk exp env))

(define (memo-thunk? obj)
  (tagged-list? obj 'memo-thunk))

(define exps
  '((define (f a (b lazy) c (d lazy-memo))
      (+ a b c d))
    (f 1 3 4 5)
    )
  )

(define (main args)
  (eval-exps exps))
