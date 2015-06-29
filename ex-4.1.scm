(define (list-of-values exps env)
  (if (no-operands? exps)
    '()
    (let ((v (eval (first-operand exps) env)))
      (cons v
            (list-of-values (rest-operands exps) env)))))

(define (list-of-values-right-to-left exps env)
  (if (no-operands? exps)
    '()
    (let ((v (list-of-values (rest-operands exps) env)))
      (cons (eval (first-operand exps) env)
            v))))
