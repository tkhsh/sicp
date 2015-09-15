;; unlessが特殊形式でなく手続きとして使えると、高階手続きに渡すことができるという点で有用である。

; (unless condition
;   usual-value
;   exceptional-value)

; ver.1
; (if (not condition)
;   usual-value
;   exceptional-value)

; ver.2
; (if condition
;   exceptional-value
;   usual-value)
