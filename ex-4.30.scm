(load "./sec-4.2.2.scm")

; original
; (define (eval-sequence exps env)
;   (cond ((last-exp? exps) (eval (first-exp exps) env))
;         (else (eval (first-exp exps) env)
;               (eval-sequence (rest-exps exps) env))))

; Cy
; (define (eval-sequence exps env)
;   (cond ((last-exp? exps) (eval (first-exp exps) env))
;         (else (actual-value (first-exp exps) env)
;               (eval-sequence (rest-exps exps) env))))

; a
; foreach-eachでdelayされているのは、proc,item,procに引き数が存在するならその引き数。
; foreachの定義の中に(begin (proc ...) ...)とある。procはdelayされているがoperatorなので強制される。
; itemsもdelayされているが、if文のcondition式に使用されるので、強制される。
; また、この例ではprocとして渡される手続きは(lambda (x) (newline) (display x))である。
; 引数xはdelayされるが (display x)はprimitiveなのでxは強制される。
(define exps-a
  '((define (for-each proc items)
      (if (null? items)
        'done
        (begin (proc (car items))
               (for-each proc (cdr items)))))

    (for-each (lambda (x) (newline) (display x))
              (list 57 321 88))))

; b
(define exps-b
  '((define (p1 x)
      (set! x (cons x '(2)))
      x)
    (define (p2 x)
      (define (p e)
        e
        x)
      (p (set! x (cons x '(2)))))
    (p1 1)
    (p2 1)
    ))

; c
; aから明らか

; d
; 本文の実装とCyを比べる。
; 本文の実装では、副作用のある特殊形式や複合手続きを並びの途中にかくと無視される。
; 本文の実装は副作用の使用方法が限定されるが、
; 複合手続きはnon-strictという原則が崩れるため、本文の実装の方が好み。

; Cyの実装を採用した場合、並びの途中で副作用の式がある場合は、実行されるタイミングが他と変わるので
; より副作用式が実行されるタイミングを考えるのが面倒になると思う。

; 他の解決策
; 例えば、並びの最後の式が評価される際に、並びの最初の式から最後の式が順に評価されるようにする。
; という方法
(define (eval-exps exps)
  (for-each (lambda (e)
             (print input-prompt)
             (print e)
             (print output-prompt)
             (print (eval e the-global-environment)))
           exps))
(define (main args)
  (for-each (lambda (e)
              (print input-prompt)
              (print e)
              (print output-prompt)
              (print (eval e the-global-environment))
              )
            exps-b)
  )

