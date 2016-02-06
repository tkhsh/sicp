(load "./ch4-query.scm")

(define queries
  '(

    (assert! (meeting accounting (Monday 9am)))
    (assert! (meeting administration (Monday 10am)))
    (assert! (meeting computer (Wednesday 3pm)))
    (assert! (meeting administration (Friday 1pm)))
    (assert! (meeting whole-company (Wednesday 4pm)))

    ; a
    (meeting ?division (Friday ?time))

    ; b
    (assert! (rule (meeting-time ?person ?day-and-time)
                   (and (job ?person (?division . ?role))
                        (or (meeting ?division ?day-and-time)
                            (meeting whole-company ?day-and-time)))))
    (meeting-time (Bitdiddle Ben) ?day-and-time)

    ; c
    (meeting-time (Hacker Alyssa P) (Wednesday ?time))

    ))

(test-queries queries)
