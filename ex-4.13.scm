(define (unbind? exp)
  (tagged-list? exp 'unbind))

(define (unbind-variable exp)
  (cadr exp))

(define (eval-unbind exp env)
  (unbind-variable! (unbind-variable exp)
                    env))

(require "./ex-4.12.scm")
(define (unbind-variable! var env)
  (scan (first-frame env)
        var
        (lambda (frame) (remove-first-binding! frame))
        (lambda (frame) (error "Unbound variable in this frame -- UNBIND!" var))))

(define (remove-first-binding! frame)
  (set-car! frame (cdar frame))
  (set-cdr! frame (cddr frame)))
(define (remove-first-binding! frame)
  (set-car! frame (cdar frame)))
