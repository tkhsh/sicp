;; original
(define (analyze-sequence exps)
  (define (sequentially proc1 proc2)
    (lambda (env) (proc1 env) (proc2 env)))
  (define (loop first-proc rest-procs)
    (if (null? rest-procs)
        first-proc
        (loop (sequentially first-proc (car rest-procs))
              (cdr rest-procs))))
  (let ((procs (map analyze exps)))
    (if (null? procs)
        (error "Empty sequence -- ANALYZE"))
    (loop (car procs) (cdr procs))))

;; Alyssa ver
(define (analyze-sequence exps)
  (define (execute-sequence procs env)
    (cond ((null? (cdr procs)) ((car procs) env))
          (else ((car procs) env)
                (execute-sequence (cdr procs) env))))
  (let ((procs (map analyze exps)))
    (if (null? procs)
        (error "Empty sequence -- ANALYZE"))
    (lambda (env) (execute-sequence procs env))))

;; exps1
(define orig1
  (lambda (env) ...))

;; exps2
(define orig2
  (lambda (env)
    ((lambda (env) ...) env)
    ((lambda (env) ...) env)))

;; exps3
(define orig3
  (lambda (env)
    ((lambda (env)
       ((lambda (env) ...) env)
       ((lambda (env) ...) env))
     env)
    ((lambda (env) ...)
     env)))

(define alyssa1
  (lambda (env)
    ((lambda (env) ...) env)))
;; (lambda (env) (execute-sequence procs env))))

(define alyssa2
  (lambda (env)
    ((lambda (env) ...) env)
    ((lambda (env) ...) env)))

;; (lambda (env) (execute-sequence procs env))))

(define alyssa3
  (lambda (env)
    ((lambda (env) ...) env)
    ((lambda (env) ...) env)
    ((lambda (env) ...) env)))

;; (lambda (env) (execute-sequence procs env))))

;; Alyssaの版は並びそのものの解析を行っていない。Alyssaの版は実行時に条件判定やループを実行することになりorignalの版より非効率的な実装である。

(define (main args)
  (print (orig1 3))
  (print (orig2 3))
  (print (orig3 3))

  (print (alyssa1 3))
  (print (alyssa2 3))
  (print (alyssa3 3))
  )
