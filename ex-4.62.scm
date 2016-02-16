(load "./ch4-query.scm")

(define queries
  '(
    (assert! (rule (last-pair (?x . ()) (?x))))
    (assert! (rule (last-pair (?u . ?x) ?y)
                   (last-pair ?x ?y)))
    (last-pair (3) ?x)
    (last-pair (1 2 3) ?x)
    (last-pair (2 ?x) (3))

    ; 以下の式は結果が返ってこない
    ; (last-pair ?x (3))
    ))

(test-queries queries)

