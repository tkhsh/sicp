(load "./sec-4.2.3.scm")

(define lazy-printable
  '(
    (define (cons x y)
      (lambda (m) (m lazy x y))) ; lazy が 'lazy でないことに注意!
    (define (car z)
      (z (lambda (i p q) p)))
    (define (cdr z)
      (z (lambda (i p q) q)))

    (define (format-lazy-list lazy-obj)
      (if (null? (cdr lazy-obj))
        (list (car lazy-obj))
        (primitive-cons (car lazy-obj)
                        (format-lazy-list (cdr lazy-obj)))))
    ))
(force-exps lazy-printable)

(define (lazy? input)
  (cond ((null? input) #f)
        ((not (eq? (car input) 'procedure)) #f)
        (else
          (eq? 'lazy (cadar (procedure-body input))))))

(define (format-value v env)
  (if (lazy? v)
    (actual-value '(format-lazy-list result-of-exp); TOFIX: 名前が衝突する恐れがある
                  (extend-environment '(result-of-exp) (list v) env))
    ; 遅延リストを直接置くとエラーになるので注意.
    ; 以下はエラーになる。
    ; (actual-value `(format-lazy-list ,v) env)
    ; 参考
    ; 以下は動く
    ; (actual-value '(format-lazy-list (cons 1 '())) env)
    ; (actual-value '(format-lazy-list test-list) env)
    v))

(define test-exps
  '(cons 1 '()) ; -> (1 '())
  ; '(format-lazy-list (cons 1 '()))
  ; '(format-lazy-list (cons 1 (cons 2 '())))
  )

(define (driver-loop)
  (prompt-for-input input-prompt)
  (let ((input (read)))
    (let ((output
            (format-value (actual-value input the-global-environment)
                          the-global-environment)))
      (announce-output output-prompt)
      (user-print output)))
  (driver-loop))

(define (main args)
  (print (format-value (actual-value test-exps the-global-environment) the-global-environment))
  )
