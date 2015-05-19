(require "./stream-lib")
(require "./ex-3.70")

(define (ramanujan-weight pair)
  (let ((i (car pair))
        (j (cadr pair)))
    (+ (* i i i) (* j j j))))

(define cube-weighted-pairs
  (weighted-pairs integers
                  integers
                  ramanujan-weight))

; (define (generate-ramanujan)
;   (define (_generate-ramanujan s1 s2 dup)
;     (if (stream-null? s2)
;       the-empty-stream
;       (let ((w1 (ramanujan-weight (stream-car s1)))
;             (w2 (ramanujan-weight (stream-car s2))))
;       (cond ((equal? dup w2)
;              (_generate-ramanujan (stream-cdr s1) (stream-cdr s2) dup))
;             ((= w1 w2)
;              (cons-stream w1
;                           (_generate-ramanujan (stream-cdr s1) (stream-cdr s2) w1)))
;             (else (_generate-ramanujan (stream-cdr s1) (stream-cdr s2) #f))))))
;   (_generate-ramanujan cube-weighted-pairs (stream-cdr cube-weighted-pairs) #f))

(define (generate-ramanujan)
  (define (_generate-ramanujan s prev count)
    (if (stream-null? s)
      the-empty-stream
      (let ((w (ramanujan-weight (stream-car s))))
        (if (equal? w prev)
          (if (> count 0)
            (_generate-ramanujan (stream-cdr s) prev (+ count 1))
            (cons-stream w
                         (_generate-ramanujan (stream-cdr s) prev (+ count 1))))
          (_generate-ramanujan (stream-cdr s) w 0)))))
  (_generate-ramanujan cube-weighted-pairs #f 0))

(define (main args)
  (display-stream (stream-take (generate-ramanujan)
                               6)))
