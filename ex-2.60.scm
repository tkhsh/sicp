(load "./util.scm")

;; ex-2.60
(define (adjoin-set x set)
  (cons x set))
(define (union-set set1 set2)
  (append set1 set2))

