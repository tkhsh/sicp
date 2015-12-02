(load "./natural_language.scm")

(define exps
  '(
    (define (parse-word word-list)
      (define (select-word words)
        (require (not (null? words)))
        (amb (car words)
             (select-word (cdr words))))
      (let ((selected-word (select-word (cdr word-list))))
        (list (car word-list)
              selected-word)))

    (parse '())
    try-again
    try-again
    try-again
    )
  )

(pre-eval-driver-loop exps)

; ;;; Starting a new problem
; ;;; Amb-Eval value:
; (sentence (simple-noun-phrase (article the) (noun student)) (verb studies))
; ;;; Amb-Eval value:
; (sentence (simple-noun-phrase (article the) (noun student)) (verb-phrase (verb studies) (prep-phrase (prep for) (simple-noun-phrase (article the) (noun student)))))
; ;;; Amb-Eval value:
; (sentence (simple-noun-phrase (article the) (noun student)) (verb-phrase (verb-phrase (verb studies) (prep-phrase (prep for) (simple-noun-phrase (article the) (noun student)))) (prep-phrase (prep for) (simple-noun-phrase (article the) (noun student)))))
; ;;; Amb-Eval value:
; (sentence (simple-noun-phrase (article the) (noun student)) (verb-phrase (verb-phrase (verb-phrase (verb studies) (prep-phrase (prep for) (simple-noun-phrase (article the) (noun student)))) (prep-phrase (prep for) (simple-noun-phrase (article the) (noun student)))) (prep-phrase (prep for) (simple-noun-phrase (article the) (noun student)))))
