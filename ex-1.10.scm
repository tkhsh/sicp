(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1) (A x (- y 1))))))

(define (f n) (A 0 n))
; => (f n) は 2n を計算する

(define (g n) (A 1 n))
; => (g n) は 2^n を計算する

(define (h n) (A 2 n))
; => h(n) = (A 2 n) = (A 1 (A 2 (- n 1)))
; さらに、(A 1 n) = (g n) = 2^n なので Y = (A 2 (- n 1)) とおくと
; (A 1 (A 2 (- n 1))) = 2^Y = 2^(A 2 (- n 1))
; よって、h(n)はh(h(n - 1))を計算する

(define (k n) (* 5 n n))

(define (main args)
  ; (print (A 1 10)) ; => 1024
  ; (print (A 2 4)) ; => 65536
  ; (print (A 3 3)) ; => 65536

  ; (print (f 2)) ; => 4
  ; (print (f 3)) ; => 6
  ; (print (f 4)) ; => 8
  ; (print (f 10)) ; => 20

  ; (print (g 2)) ; => 4
  ; (print (g 3)) ; => 8
  ; (print (g 4)) ; => 16
  ; (print (g 10)) ; => 1024

  ; (print (h 2)) ; => 4
  ; (print (h 3)) ; => 16
  ; (print (h 4)) ; => 65536
  ; (print (h 5)) ; => ...
  )
