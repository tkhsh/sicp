(require "./evaluator.scm")
; a
(define (lookup-variable-value var env)
  (define (env-loop env)
    (define (scan vars vals)
      (cond ((null? vars)
             (env-loop (enclosing-environment env)))
            ((eq? var (car vars))
             (car vals))
            (else (scan (cdr vars) (cdr vals)))))
    (if (eq? env the-empty-environment)
        (error "Unbound variable" var)
        (let ((frame (first-frame env)))
          (scan (frame-variables frame)
                (frame-values frame)))))
  (let ((result (env-loop env)))
    (if (eq? '*unassigned* result)
      (error "unassigned variable")
      result)))

; b
; (lambda ⟨vars⟩
;   (define u ⟨e1⟩)
;   (define v ⟨e2⟩)
;   ⟨e3⟩)

; (lambda ⟨vars⟩
;   (let ((u '*unassigned*)
;         (v '*unassigned*))
;     (set! u ⟨e1⟩)
;     (set! v ⟨e2⟩)
;     ⟨e3⟩))
(require "./ex-4.8.scm")
(define (scan-out-defines exps)
  (let ((define-exps (filter definition? exps))
        (non-define-exps (filter (lambda (e) (not (definition? e))) exps)))
    (make-let (map (lambda (e) (list (definition-variable e) '*unassigned*))
                   define-exps)
              (append (map (lambda (e) (make-assignment (definition-variable e)
                                                        (definition-value e)))
                           define-exps)
                      non-define-exps))))

(define (main args)
  (print (scan-out-defines '((define u <e1>)
                             (define v <e2>)
                             <e3>))))

;; c
;; procedure-body
;; <良い点>
;; ユーザーが入力した定義がそのまま保持できるため、デバッグ時などに便利
;; <悪い点>
;; 効率が悪くなる.procedure-bodyはapplyする度に呼ばれるので呼び出し頻度が高い.

;; make-procedure
;; <良い点>
;; scan-out-definesでコードを変換するのが一度だけになるため、効率が良い。
;; <悪い点>
;; ユーザーが入力した定義が保持が難しくなるため、デバッグが難しくなる.
