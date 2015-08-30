;; 環境図を描く
;; 逐次defineはcurrent-frameを実行順に逐次書き換えることになる。
;; letを使用した場合はlambda式が導出され、一度に変数を定義する新しいフレームができる。

;; 変換したプログラムに余計なフレームがあるのはなぜか. 環境構造のこの違いが正しいプログラムの行動に違いを生じないのはなぜか説明せよ.
;; varsにu, vがあった時、defineした場合は直接環境が上書きされる。新しいフレームが作られた場合は、shadowによって上書きされる。両方上書きされることは変わらず、動作に違いが生じることはない。

;; 余計なフレームを構成せずに解釈系が内部定義の「同時」有効範囲規則を実装する方法を設計
;; 方針: current-frameの書き換えを行うように修正する。「同時」なので、とりあえず*unassigned*を代入する方針
;;       つまり、letではなくdefineを使うようにする。
; (lambda <vars>
;   (define u '*unassigned*)
;   (define v '*unassigned*)
;   (set! u <e1>)
;   (set! v <e2>)
;   <e3>)
(require "./evaluator.scm")
(define (scan-out-defines exps)
  (let ((define-exps (filter definition? exps))
        (non-define-exps (filter (lambda (e) (not (definition? e))) exps)))
    (append (make-unassigned-definitions (map definition-variable define-exps))
                        (map (lambda (e) (make-assignment (definition-variable e)
                                                          (definition-value e)))
                             define-exps)
                        non-define-exps)))

(define (make-definitoin var exp)
  (list 'define var exp))

(define (make-unassigned-definitions variables)
  (map (lambda (var) (make-definitoin var '*unassigned*))
       variables))

(define (main args)
  (print (scan-out-defines
           '((define u <e1>)
             <e3>
             (define v <e2>)
             ))))
