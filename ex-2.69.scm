(load "./sec-2.3.4.scm")

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

(define (successive-merge leaf-set)
  (cond ((null? (cdr leaf-set)) (car leaf-set))
        (else (successive-merge
                (adjoin-set (make-code-tree (car leaf-set)
                                            (cadr leaf-set))
                            (cddr leaf-set))))))

(print (generate-huffman-tree '((A 4) (B 2) (C 1) (D 1))))

