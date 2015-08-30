; internal definition
; (lambda ⟨vars⟩
;   (let ((u '*unassigned*)
;         (v '*unassigned*))
;     (let ((a ⟨e1⟩)
;           (b ⟨e2⟩))
;       (set! u a)
;       (set! v b))
;     ⟨e3⟩))

(define (solve f y0 dt)
  (define y (integral (delay dy) y0 dt))
  (define dy (stream-map f y))
  y)

; 内部定義を上記のように掃き出すようにするとsolveは正常に動作しない。

; <e2>を評価する際、uは*unassigned*がbindされている。
; <e2>の中でuに<e1>の評価結果がbindされていることを前提としていると問題になる。

; (stream-map f y)はyに(integral (delay dy) y0 dt)の評価結果がbindされていることを前提としている。
; 実際にはyは*unassigned*がbindされているため、(stream-map f y)を評価する際、エラーが発生し、意図した結果と異なる動作になる。
