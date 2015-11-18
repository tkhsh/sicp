(load "./sec-4.3.scm")

(define exps
  '(
    (define (father-member family families)
      (member (father family)
              (map (lambda (f) (father f)) families)))

    (define (map proc lst)
      (if (null? lst)
        '()
        (cons (proc (car lst)) (map proc (cdr lst)))))

    (define (cons-family daughter father) (list daughter father))
    (define (father family) (car (cdr family)))
    (define (daughter family) (car family))

    (define (solve)
      (let ((mary-family (cons-family 'Mary (amb 'Moore 'Downing 'Hall 'Parker 'Barnacle))))
        (require (eq? (father mary-family) 'Moore))
        (let ((melissa-family (cons-family 'Melissa (amb 'Moore 'Downing 'Hall 'Parker 'Barnacle))))
          (require (eq? (father melissa-family) 'Barnacle))
          (require (not (father-member melissa-family (list mary-family))))
          (let ((gabrielle-family (cons-family 'Gabrielle (amb 'Moore 'Downing 'Hall 'Parker 'Barnacle))))
            (require (not (eq? (father gabrielle-family) 'Parker)))
            (require (not (father-member gabrielle-family (list mary-family melissa-family))))
            (let ((rosalind-family (cons-family 'Rosalind (amb 'Moore 'Downing 'Hall 'Parker 'Barnacle))))
              (require (not (eq? (father rosalind-family) 'Hall)))
              (require (not (father-member rosalind-family (list mary-family melissa-family gabrielle-family))))
              (let ((lorna-family (cons-family 'Lorna (amb 'Moore 'Downing 'Hall 'Parker 'Barnacle))))
                (require (not (father-member lorna-family (list mary-family
                                                                melissa-family
                                                                gabrielle-family
                                                                rosalind-family))))
                (let ((gabrielle-fathers-yacht (find-yacht (father gabrielle-family))))
                  (if gabrielle-fathers-yacht
                    (require (eq? gabrielle-fathers-yacht
                                  (find-daughter 'Parker (list mary-family
                                                               melissa-family
                                                               gabrielle-family
                                                               rosalind-family
                                                               lorna-family)))))
                  (list mary-family
                        gabrielle-family
                        lorna-family
                        rosalind-family
                        melissa-family))))))))

    (define (find-yacht fr)
      (cond ((eq? fr 'Barnacle) 'Gabrielle)
            ((eq? fr 'Moore) 'Lorna)
            ((eq? fr 'Hall) 'Rosalind)
            ((eq? fr 'Downing) 'Melissa)
            (else false)))

    (define (find-daughter fr families)
      (cond ((null? families) false)
            ((eq? (father (car families)) fr) (daughter (car families)))
            (else (find-daughter fr (cdr families)))))

    (solve)
    try-again
    try-again
    try-again
    )
  )

(pre-eval-driver-loop exps)
; ;;; Amb-Eval value:
; ((Mary Moore) (Gabrielle Hall) (Lorna Downing) (Rosalind Parker) (Melissa Barnacle))

; Q. how many solutions there are if we are not told that Mary Ann's last name is Moore
; A. 3 sets
; ((Mary Moore) (Gabrielle Hall) (Lorna Downing) (Rosalind Parker) (Melissa Barnacle))
; ((Mary Downing) (Gabrielle Hall) (Lorna Moore) (Rosalind Parker) (Melissa Barnacle))
; ((Mary Hall) (Gabrielle Moore) (Lorna Parker) (Rosalind Downing) (Melissa Barnacle))
