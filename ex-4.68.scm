(load "./ch4-query.scm")

(define queries
  '(
    (assert! (rule (reverse (?x . ()) (?x))))
    (assert! (rule (reverse (?u . ?x) ?z)
                   (and (reverse ?x ?y)
                        (append-to-form ?y (?u) ?z))))

    ; (reverse (1) ?l)
    (reverse (1 2 3) ?l)
    ))

(test-queries queries)
