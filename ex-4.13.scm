(define (unbind? exp)
  (tagged-list? exp 'unbind))

(define (unbind-variable exp)
  (cadr exp))

(define (eval-unbind exp env)
  (unbind-variable! (unbind-variable exp)
                    env))

(require "./ex-4.12.scm")
(define (unbind-variable! var env)
  (scan-env env
            var
            (lambda (vars vals frame)
              (if (eq? vars (frame-variables frame))
                (begin (set-car! frame (cdr vars))
                       (set-cdr! frame (cdr vals)))
                (begin
                  (set-cdr! (previous-cell (frame-variables frame) vars) (cdr vars))
                  (set-cdr! (previous-cell (frame-values frame) vals) (cdr vals)))))
            (lambda (vars vals frame) (error "Unbound variable in this frame -- UNBIND" var))
            (lambda () (error "Unexpected error -- UNBIND" var))))

(define (previous-cell whole partial)
  (let go ((rest (cdr whole))
           (prev whole))
    (cond ((null? rest) #f)
          ((eq? rest partial) prev)
          (else (go (cdr rest) rest)))))
  ; (let ((whole '(a b c d)))
  ;   (print (previous-cell whole (cdr whole)))
  ;   (print (previous-cell whole (cddr whole)))
  ;   (print (previous-cell whole whole))

(require "./evaluator.scm")
(define (main args)
  (define vars-vals-pair1
    (cons '(var1 var2)
          '(10 20)))
  (define vars-vals-pair2
    (cons '(a b)
          '(1 2)))

  ; ; 1. 環境全体に変数が見つからなかった場合
  ; ; ex.
  ; ; (set! 'var1 10)
  ; ; (set! 'var2 20)
  ; ; (unbind 'not-exist)
  ; (define (test-not-found-in-frame)
  ;   (let ((env (extend-environment (car vars-vals-pair1)
  ;                                  (cdr vars-vals-pair1)
  ;                                  the-empty-environment)))
  ;   (unbind-variable! 'not-exist env)))
  ; ; expect -> ERROR: Unbound variable in this frame -- UNBIND
  ; (print (test-not-found-in-frame))

  ; ; 2. 最初のフレームに変数が見つからなかった場合
  ; ; ex.
  ; ; (set! 'var1 10)
  ; ; (set! 'var2 20)
  ; ; (define (f a b)
  ; ;   (unbind 'var1))
  ; ; (f 1 2)
  ; (define (test-not-found-in-first-frame)
  ;   (let ((env (extend-environment (car vars-vals-pair2)
  ;                                  (cdr vars-vals-pair2)
  ;                                  (extend-environment (car vars-vals-pair1)
  ;                                                      (cdr vars-vals-pair1)
  ;                                                      the-empty-environment))))
  ;   (unbind-variable! 'var1 env)))
  ; ; expect -> ERROR: Unbound variable in this frame -- UNBIND
  ; (print (test-not-found-in-first-frame))

  ; ; 3. 最初のフレームにだけ変数があった場合
  ; ; ex.
  ; ; (set! 'var1 10)
  ; ; (set! 'var2 20)
  ; ; (define (f a b)
  ; ;   (unbind 'a))
  ; ; (f 1 2)
  ; (define (test-found-only-in-first-frame)
  ;   (let ((env (extend-environment (car vars-vals-pair2)
  ;                                  (cdr vars-vals-pair2)
  ;                                  (extend-environment (car vars-vals-pair1)
  ;                                                      (cdr vars-vals-pair1)
  ;                                                      the-empty-environment))))
  ;     (unbind-variable! 'b env)
  ;     env))
  ; ; expect -> '(((a b) 1 2) ((var1 var2 var3) 10 20 30))
  ; (print (test-found-only-in-first-frame))

  ; 4. 最初のフレーム以外にも変数があった場合
  ; ; ex.
  ; ; (set! 'var1 10)
  ; ; (set! 'var2 20)
  ; ; (define (f a b)
  ; ;   (let ((var1 100))
  ; ;     (unbind 'var1)))
  ; ; (f 1 2)
  ; (define (test-found-in-first-frame-and-another-frame)
  ;   (let ((env (extend-environment (cons 'var1 (car vars-vals-pair2))
  ;                                  (cons 100 (cdr vars-vals-pair2))
  ;                                  (extend-environment (car vars-vals-pair1)
  ;                                                      (cdr vars-vals-pair1)
  ;                                                      the-empty-environment))))
  ;     (unbind-variable! 'var1 env)
  ;     env))
  ; expect -> '(((a b) 1 2) ((var1 var2) 10 20))
  ; (print (test-found-in-first-frame-and-another-frame))
  )
