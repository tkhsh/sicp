(load "./ch4-query.scm")

(define queries
  '(
    (assert! (son Adam Cain))
    (assert! (son Cain Enoch))
    (assert! (son Enoch Irad))
    (assert! (son Irad Mehujael))
    (assert! (son Mehujael Methushael))
    (assert! (son Methushael Lamech))
    (assert! (wife Lamech Ada))
    (assert! (son Ada Jabal))
    (assert! (son Ada Jubal))

    (assert! (rule (grand-child ?g ?s)
                   (and (son ?f ?s)
                        (son ?g ?f))))
    (grand-child Cain ?s)

    (assert! (rule (son ?m ?s)
                   (and (wife ?m ?w)
                        (son ?w ?s))))
    (son Lamech ?s)

    (grand-child Methushael ?s)
    ))

(test-queries queries)
