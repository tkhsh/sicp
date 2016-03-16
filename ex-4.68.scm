(load "./ch4-query.scm")

(define queries
  '(
    (assert! (rule (reverse (?x . ()) (?x))))
    (assert! (rule (reverse (?u . ?x) ?z)
                   (and (reverse ?x ?y)
                        (append-to-form ?y (?u) ?z))))

    (reverse (1 2 3) ?x)

    ; 上記の式には答えることができるが以下の式は無限ループに陥る。
    ; (reverse ?x (1 2 3))
    ))

(test-queries queries)
