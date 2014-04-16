(load "./util.scm")
(load "./ex-2.65.scm")

(define (lookup given-key tree-of-records)
  (let ((entry-of-tree (entry tree-of-records)))
  (cond ((null? tree-of-records) #f)
        ((= given-key (key entry-of-tree)) entry-of-tree)
        ((< given-key (key entry-of-tree))
         (lookup given-key (left-branch tree-of-records)))
        ((> given-key (key entry-of-tree))
         (lookup given-key (right-branch tree-of-records))))))

