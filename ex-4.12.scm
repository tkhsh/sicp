(define (lookup-variable-value var env)
  (scan-env env
            var
            (lambda (vars vals frame) (car vals))
            (lambda (vars vals frame) (scan-env (enclosing-environment env)))
            (lambda () (error "Unbound variable" var))))

(define (set-variable-value! var val env)
  (scan-env env
            var
            (lambda (vars vals frame) (set-car! vals val))
            (lambda (vars vals frame) (scan-env (enclosing-environment env)))
            (lambda () (error "Unbound variable -- SET!" var))))

(define (define-variable! var val env)
  (scan-env env
            var
            (lambda (vars vals frame) (set-car! vals val))
            (lambda (vars vals frame) (add-binding-to-frame! var val frame))
            (lambda () (error "Unexpected error -- DEFINE" var))))

(define (scan-frame frame target-variable found not-found)
  (let go ((vars (frame-variables frame))
           (vals (frame-values frame)))
    (cond ((null? vars)
           (not-found vars vals frame))
          ((eq? target-variable (car vars))
           (found vars vals frame))
          (else (go (cdr vars) (cdr vals))))))

(define (scan-env env var found not-found-in-frame not-found-in-env)
  (if (eq? env the-empty-environment)
    (not-found-in-env)
    (scan-frame (first-frame env)
                var
                found
                not-found-in-frame)))

; TODO
; (define (set-first-binding! frame val)
;   (set-car! (frame-values frame) val))
; (define (set-first-binding! frame val)
;   (set-cdr! (car frame) val))
