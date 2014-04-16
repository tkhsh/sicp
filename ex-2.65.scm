(load "./util.scm")

(define (entry tree) (car tree))

(define (left-branch tree) (cadr tree))

(define (right-branch tree) (caddr tree))

(define (make-tree entry left right)
  (list entry left right))

(define (element-of-set? x set)
     (cond ((null? set) #f)
           ((= x (entry set)) #t)
           ((< x (entry set))
            (element-of-set? x (left-branch set)))
           ((> x (entry set))
            (element-of-set? x (right-branch set)))))

(define (adjoin-set x set)
     (cond ((null? set) (make-tree x '() '()))
           ((= x (entry set)) set)
           ((< x (entry set))
            (make-tree (entry set)
                       (adjoin-set x (left-branch set))
                       (right-branch set)))
           ((> x (entry set))
            (make-tree (entry set) (left-branch set)
                       (adjoin-set x (right-branch set))))))

;; 2.63
(define (tree->list-1 tree)
     (if (null? tree)
         '()
         (append (tree->list-1 (left-branch tree))
                 (cons (entry tree)
                       (tree->list-1
                         (right-branch tree))))))
(define (tree->list-2 tree)
 (define (copy-to-list tree result-list)
   (if (null? tree)
       result-list
       (copy-to-list (left-branch tree)
                     (cons (entry tree)
                           (copy-to-list
                             (right-branch tree)
                             result-list)))))
 (copy-to-list tree '()))

;; 2.64
(define (list->tree elements)
         (car (partial-tree elements (length elements))))
(define (partial-tree elts n)
 (if (= n 0)
     (cons '() elts)
     (let ((left-size (quotient (- n 1) 2)))
       (let ((left-result
              (partial-tree elts left-size)))
         (let ((left-tree (car left-result))
               (non-left-elts (cdr left-result))
               (right-size (- n (+ left-size 1))))
           (let ((this-entry (car non-left-elts))
                 (right-result (partial-tree (cdr non-left-elts)
                                             right-size)))
             (let ((right-tree (car right-result))
                   (remaining-elts
                    (cdr right-result)))
               (cons (make-tree this-entry left-tree right-tree)
                     remaining-elts))))))))
;; ex-2.65
(define (union-set-l s1 s2)
  (cond ((null? s1) s2)
        ((null? s2) s1)
        (else (let ((x1 (car s1)) (x2 (car s2)))
              (cond ((= x1 x2)
                     (cons x1
                           (union-set-l (cdr s1)
                                      (cdr s2))))
                    ((< x1 x2)
                     (cons x1
                           (union-set-l (cdr s1) s2)))
                    ((< x2 x1)
                     (cons x2
                           (union-set-l s1 (cdr s2)))))))))
(define (union-set t1 t2)
  (cond ((null? t1) t2)
        ((null? t2) t1)
        (else (list->tree (union-set-l (tree->list-2 t1)
                                       (tree->list-2 t2))))))
(print (union-set (list->tree '(1 3 5 7 9 10)) (list->tree '(2 5 7 10 13))))

(define (intersection-set-l set1 set2)
  (if (or (null? set1) (null? set2))
      '()
      (let ((x1 (car set1)) (x2 (car set2)))
        (cond ((= x1 x2)
               (cons x1
                     (intersection-set-l (cdr set1)
                                       (cdr set2))))
              ((< x1 x2)
               (intersection-set-l (cdr set1) set2))
              ((< x2 x1)
               (intersection-set-l set1 (cdr set2)))))))
(define (intersection-set t1 t2)
  (cond ((null? t1) t2)
        ((null? t2) t1)
        (else (list->tree (intersection-set-l (tree->list-2 t1)
                                              (tree->list-2 t2))))))
(print (intersection-set (list->tree '(1 3 5 7 9 10)) (list->tree '(2 5 7 10 13))))
