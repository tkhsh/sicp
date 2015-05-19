(require "./stream-lib")
(require "./ex-3.70")

(define (sqrt-weight pair)
  (let ((i (car pair))
        (j (cadr pair)))
    (+ (* i i) (* j j))))

(define sqrt-weighted-pairs
  (weighted-pairs integers
                  integers
                  sqrt-weight))

(define (generate-sqrt-sum)
  (define (_generate-ramanujan s prev count)
    (if (stream-null? s)
      the-empty-stream
      (let ((w (sqrt-weight (stream-car s))))
        (if (equal? w prev)
          (_generate-ramanujan (stream-cdr s) prev (+ count 1))
          (if (= count 3)
            (cons-stream w
                         (_generate-ramanujan (stream-cdr s) prev 0))
            (_generate-ramanujan (stream-cdr s) w 0))))))
  (_generate-ramanujan sqrt-weighted-pairs #f 0))

(define (main args)
  (display-stream (stream-take (generate-sqrt-sum)
                               6)))
