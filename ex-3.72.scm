(require "./stream-lib")
(require "./ex-3.70")

(define (square-weight pair)
  (let ((i (car pair))
        (j (cadr pair)))
    (+ (* i i) (* j j))))

(define square-weighted-pairs
  (weighted-pairs integers
                  integers
                  square-weight))

(define (generate-square-sum)
  (define (go s prev count)
    (if (stream-null? s)
      the-empty-stream
      (let ((w (square-weight (stream-car s))))
        (if (equal? w prev)
          (go (stream-cdr s) prev (+ count 1))
          (if (= count 3)
            (cons-stream prev
                         (go (stream-cdr s) prev 1))
            (go (stream-cdr s) w 1))))))
  (go square-weighted-pairs #f 1))

(define (main args)
  (display-stream (stream-take (generate-square-sum)
                               6)))
