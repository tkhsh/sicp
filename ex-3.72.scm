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

(define (stream-group-by s key-selector)
  (define (go s key elements)
    (if (stream-null? s)
      (cons-stream (cons key elements) the-empty-stream)
      (let ((k (key-selector (stream-car s))))
        (if (equal? k key)
          (go (stream-cdr s) key (cons (stream-car s) elements))
          (cons-stream (cons key elements)
                       (go (stream-cdr s) k (list (stream-car s))))))))
  (if (stream-null? s)
    the-empty-stream
    (go (stream-cdr s) (key-selector (stream-car s)) (list (stream-car s)))))

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

(define (generate-square-sum)
  (stream-filter (lambda (g) (= (length (cdr g)) 3))
                 (stream-group-by square-weighted-pairs square-weight)))

(define (main args)
  (display-stream (stream-take (generate-square-sum)
                               6))
  (display-stream (stream-group-by (stream-enumerate-interval 1 20)
                                   (lambda (x) (< x 10)))))
