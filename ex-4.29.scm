(require "./sec-4.2.2.scm")
(require "./ex-4.27.scm")
'((define (square x)
   (* x x))

 ;;; L-Eval input:
 (square (id 10))
 ;;; L-Eval value:
 ;; ⟨応答⟩
 ;; memo化あり 100
 ;; memo化なし 100

 ;;; L-Eval input:
 count
 ;;; L-Eval value:
 ;; ⟨応答⟩
 ;; memo化あり 1
 ;; memo化なし 2)
