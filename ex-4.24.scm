;; ここの構文について比較することが望ましい。

;; 一番効率化される手続きの再起呼び出しを比較する。
(require "./evaluator.scm")
(require "./sec-4.1.7.scm")
(require "./ex-4.22.scm")

(define (main args)
  (eval '(define (fib n)
           (cond ((= n 0) 0)
                 ((= n 1) 1)
                 (else (+ (fib (- n 1))
                          (fib (- n 2))))))
        the-global-environment)
  (print
    (eval '(fib 25)
          the-global-environment))
  )

