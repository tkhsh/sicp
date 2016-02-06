(load "./ch4-query.scm")

(define queries
  '(

    (assert! (rule (replace ?person-1 ?person-2)
                   (and (or (and (job ?person-1 ?job)
                                 (job ?person-2 ?job))
                            (and (job ?person-1 ?job-1)
                                 (job ?person-2 ?job-2)
                                 (can-do-job ?job-1 ?job-2)))
                        (not (same ?person-1 ?person-2)))))

    ; a
    (replace ?x (Fect Cy D))

    ; b
    (and (replace ?person-1 ?person-2)
         (salary ?person-1 ?amount-1)
         (salary ?person-2 ?amount-2)
         (lisp-value < ?amount-1 ?amount-2))

    ))

(test-queries queries)
