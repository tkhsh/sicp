(load "./ch4-query.scm")

(define queries
  '(

    (assert! (rule (big-shot ?person ?division)
                   (and (job ?person (?division . ?role-1))
                        (supervisor ?person ?manager)
                        (not (job ?manager (?division . ?role-2)))
                        )))

    (big-shot (Bitdiddle Ben) computer)

    ))

(test-queries queries)

