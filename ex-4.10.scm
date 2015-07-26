; ver.1
; (x = 3)

(define (assignment? exp)
  (if (pair? exp)
    (eq? (cadr exp) '=)
    false))

(define (assignment-variable exp) (car exp))

(define (assignment-value exp) (caddr exp))

(define (make-assignment var val)
  (list var '= val))

; TOFIX (define = 3) ????


; ver.2
; (let (var1 exp1
;       var2 exp2
;       ...)
;   body)

(define (let-bindings exp)
  (partition-by-number 2 (cadr exp)))

(define (partition-by-number n lst)
  (define (go c product rest)
    (if (= c 0)
      (cons product (go n '() rest))
      (if (null? rest)
        product
        (go (- c 1)
            (append product (list (car rest)))
            (cdr rest)))))
  (go n '() lst))

(define (main args)
  ; (print (partition-by-number 2 '(1 2 3 4)))
  (print (let-bindings '(let (var1 exp1 var2 exp2 var3 exp3) body)))
  )
