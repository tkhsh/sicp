(require "./stream-lib")
(require "./ex-3.70")

(define (ramanujan-weight pair)
  (let ((i (car pair))
        (j (cadr pair)))
    (+ (* i i i) (* j j j))))

(define ramanujan-weighted-pairs
  (weighted-pairs integers
                  integers
                  ramanujan-weight))

; (define (generate-ramanujan-numbers)
;   (define (go s1 s2 dup)
;     (if (stream-null? s2)
;       the-empty-stream
;       (let ((w1 (ramanujan-weight (stream-car s1)))
;             (w2 (ramanujan-weight (stream-car s2))))
;       (cond ((equal? dup w2)
;              (go (stream-cdr s1) (stream-cdr s2) dup))
;             ((= w1 w2)
;              (cons-stream w1
;                           (go (stream-cdr s1) (stream-cdr s2) w1)))
;             (else (go (stream-cdr s1) (stream-cdr s2) #f))))))
;   (go ramanujan-weighted-pairs (stream-cdr ramanujan-weighted-pairs) #f))

(define (generate-ramanujan-numbers)
  (define (go s prev count)
    (if (stream-null? s)
      the-empty-stream
      (let ((w (ramanujan-weight (stream-car s))))
        (if (equal? w prev)
          (if (= count 0)
            (cons-stream w
                         (go (stream-cdr s) prev (+ count 1)))
            (go (stream-cdr s) prev (+ count 1)))
          (go (stream-cdr s) w 0)))))
  (go ramanujan-weighted-pairs #f 0))

(define (generate-ramanujan-numbers)
  (define (go s w0)
    (let* ((e1 (stream-ref s 0))
           (e2 (stream-ref s 1))
           (w1 (ramanujan-weight e1))
           (w2 (ramanujan-weight e2)))
      (if (= w1 w2)
        (cons-stream (cons w1 e1)
                     (go (stream-cdr s) w1))
        (if (= w1 w0)
          (cons-stream (cons w1 e1)
                       (go (stream-cdr s) w1))
          (go (stream-cdr s) w1)))))
  (go ramanujan-weighted-pairs 0))

(define (main args)
  (display-stream (stream-take (generate-ramanujan-numbers)
                               12)))
