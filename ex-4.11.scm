; (define (make-frame variables values)
;   (cons variables values))
(define (make-frame variables values)
  (list (map cons
             variables
             values)))

; (define (frame-variables frame) (car frame))
(define (frame-variables frame) (map car (car frame)))

; (define (frame-values frame) (cdr frame))
(define (frame-values frame) (map cdr (car frame)))

; (define (add-binding-to-frame! var val frame)
;   (set-car! frame (cons var (car frame)))
;   (set-cdr! frame (cons val (cdr frame))))
(define (add-binding-to-frame! var val frame)
  (set-car! frame (cons (cons var val) (car frame))))

; TOFIX in ex-4.12
; lookup-variable-value, set-variable-value! and define-variable! isn't work
