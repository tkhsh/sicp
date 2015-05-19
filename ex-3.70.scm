(require "./stream-lib")

(define (merge-weighted s1 s2 weight)
  (cond ((stream-null? s1) s2)
        ((stream-null? s2) s1)
        (else
          (let ((s1-car (stream-car s1))
                (s2-car (stream-car s2)))
            (cond ((< (weight s1-car) (weight s2-car))
                   (cons-stream s1-car (merge-weighted (stream-cdr s1) s2 weight)))
                  ((> (weight s1-car) (weight s2-car))
                   (cons-stream s2-car (merge-weighted s1 (stream-cdr s2) weight)))
                  (else
                    (cons-stream s1-car
                                 (merge-weighted (stream-cdr s1) s2 weight))))))))

(define (weighted-pairs s t weight)
  (cons-stream
    (list (stream-car s) (stream-car t))
    (merge-weighted
      (stream-map (lambda (x) (list (stream-car s) x))
                  (stream-cdr t))
      (weighted-pairs (stream-cdr s) (stream-cdr t) weight)
      weight)))

; a (sum i + j)
(define a
  (weighted-pairs integers
                  integers
                  (lambda (pair) (+ (car pair) (cadr pair)))))


; b 2i + 3j + 5ij
(define (w pair)
  (let ((i (car pair))
        (j (cadr pair)))
    (+ (* 2 i) (* 3 j) (* 5 i j))))

(define b
  (let ((not-2-3-5 (stream-filter (lambda (x)
                                    (and (not (= (mod x 2) 0))
                                         (not (= (mod x 3) 0))
                                         (not (= (mod x 5) 0))))
                                  integers)))
    (weighted-pairs not-2-3-5
                    not-2-3-5
                    w)))

(define (main args)
  (define s1
    (scale-stream integers 2))
  (define s2
    (scale-stream integers 3))
  (display-stream (stream-take (merge-weighted s1 s2 (lambda (x) x))
                               10))
  (print "------------------------------------------")
  (display-stream (stream-take a 10))
  (print "------------------------------------------")
  (display-stream (stream-take (stream-map (lambda (pair)
                                             (cons pair (w pair)))
                                           b)
                               20)))
