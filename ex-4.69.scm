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
    (assert! (rule (grandchild ?g ?s)
                   (and (son ?f ?s)
                        (son ?g ?f))))
    (assert! (rule (son ?m ?s)
                   (and (wife ?m ?w)
                        (son ?w ?s))))

    (assert! (rule (end-in-grandchild (grandchild . ()))))
    (assert! (rule (end-in-grandchild (?f . ?r))
                   (end-in-grandchild ?r)))
    ; (end-in-grandchild (great grandchild))
    ; (end-in-grandchild (great great grandchild))

    (assert! (rule ((great . ?rel) ?g ?d)
                   (and (son ?g ?gc)
                        (?rel ?gc ?d)
                        (end-in-grandchild ?rel))))
    (assert! (rule ((grandchild . ()) ?g ?gc)
                   (grandchild ?g ?gc)))

    ((great grandchild) ?g ?ggs)
    (?relationship Adam Irad)
    ))

(test-queries queries)
