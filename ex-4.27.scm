(require "./sec-4.2.2.scm")

(define exps
  '((define count 0)

    (define (id x)
      (set! count (+ count 1))
      x)

    (define w (id (id 10)))

    ;;; L-Eval input:
    count
    ;;; L-Eval value:
    ;; ⟨応答⟩ 1

    ;;; L-Eval input:
    w
    ;;; L-Eval value:
    ;; ⟨応答⟩ 10

    ;;; L-Eval input:
    count
    ;;; L-Eval value:
    ;; ⟨応答⟩ 2
    ))

(define test
  '((define (f x) (if-a x))
    (define (if-a x)
      (if (> 2 1)
        x
        2))
    (define (plus x) (+ 2 x))
    (f (plus 2))))

(define (main args)
  (for-each (lambda (e)
              (print input-prompt)
              (print e)
              (print output-prompt)
              (print (eval e the-global-environment))
              ; (print e)
              )
            test)
  )

