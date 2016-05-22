(define (factorial n)
  (if (= n 1)
    1
    (mul n (factorial (- n 1)))))

(define (i-factorial n)
  (fact-iter 1 1 n))
(define (fact-iter product counter max-count)
  (if (> counter max-count)
    product
    (fact-iter (mul counter product)
               (+ counter 1)
               max-count)))

(define (main args)
  ; (time (factorial 50000))
  ; real  10.225
  ; user  15.680
  ; sys    0.730

  (time (i-factorial 50000))
  ; real   2.346
  ; user   4.940
  ; sys    0.450
  )
