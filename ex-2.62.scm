(load "./util.scm")
(load "./ex-2.61.scm")

;; 2.62
(define (union-set set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        ((element-of-set? (car set1) set2) (union-set (cdr set1) set2))
        (else (union-set (cdr set1) (adjoin-set (car set1) set2)))))

(define (union-set s1 s2)
  (cond ((null? s1) s2)
        ((null? s2) s1)
        (else (let ((x1 (car s1)) (x2 (car s2)))
              (cond ((= x1 x2)
                     (cons x1
                           (union-set (cdr s1)
                                      (cdr s2))))
                    ((< x1 x2)
                     (cons x1
                           (union-set (cdr s1) s2)))
                    ((< x2 x1)
                     (cons x2
                           (union-set s1 (cdr s2)))))))))

