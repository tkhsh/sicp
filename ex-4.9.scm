(require "./evaluator.scm")
; ver.1
; (while (> x 10)
;        (print x)
;        (set! x (+ x 1)))
;
; ex
; (let recur ()
;   (if cond
;     (begin body
;            (recur))
;     false))

(define (while? exp)
  (tagged-list? exp 'while))

(define (while-cond exp)
  (cadr exp))

(define (while-body exp)
  (cddr exp))

(define (make-named-let name bindings body)
  (cons* 'let name bindings body))

(define (while->let exp)
  `(let recur ()
     (if ,(while-cond exp)
       (begin ,@(while-body exp)
              (recur))
       false)))

(define (main args)
  (print (while->let
           '(while (> x 10)
                   (print x)
                   (set! x (+ x 1))))))

; ver.2
; (for (var init-val cond next)
;      body)
;
; (let recur ((var init-val))
;   (if cond
;     (begin body
;            (recur next))
;     false)))

; ex
; (let recur ()
;   (if (> x 10)
;     (begin (print x)
;            (set! x (+ x 1))
;            (recur))
;     false))

(define (for-var exp)
  (car (cadr exp)))

(define (for-init-val exp)
  (cadr (cadr exp)))

(define (for-cond exp)
  (caddr (cadr exp)))

(define (for-next exp)
  (cadddr (cadr exp)))

(define (for-body exp)
  (cddr exp))

(define (for->let exp)
  `(let recur ((,(for-var exp) ,(for-init-val exp)))
     (if ,(for-cond exp)
       (begin ,@(for-body exp)
              (recur ,(for-next exp)))
       false)))

(define (main args)
  (print (for->let
           '(for (i 1 (< i 10) (+ i 1))
                 (print x)
                 )))
  '(for (i '(1 2 3) (not (null? i)) (cdr i))
        (set! stack (cons i stack)))
  ; stack => ((1 2 3))
  ;          ((2 3) (1 2 3))
  ;          ((3) (2 3) (1 2 3))
  )
