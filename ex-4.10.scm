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
  (group-by-number 2 (cadr exp)))

(define (group-by-number n lst)
  (define (go c group rest)
    (if (= c 0)
      (cons group (go n '() rest))
      (if (null? rest)
        group
        (go (- c 1)
            (append group (list (car rest)))
            (cdr rest)))))
  (go n '() lst))

(define (main args)
  ; (print (group-by-number 2 '(1 2 3 4)))
  (print (let-bindings '(let (var1 exp1 var2 exp2 var3 exp3) body)))
  )
