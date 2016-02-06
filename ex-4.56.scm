(load "./ch4-query.scm")

(define exps
  '(
    ; a
    (and (supervisor ?person (Bitdiddle Ben))
         (address    ?person ?where))

    ; ; b
    (and (salary ?person ?amount)
         (salary (Bitdiddle Ben) ?x)
         (lisp-value < ?amount ?x))

    ; c
    (and (supervisor ?person ?s)
         (not (job ?s (computer . ?any)))
         (job ?s ?pos))

    ; (and (job ?x ?j)
    ;      (not (job ?x (computer . ?any)))
    ;      (supervisor ?person ?x))
    ))

(test-queries exps)
