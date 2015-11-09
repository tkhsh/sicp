(load "./sec-4.3.scm")

(define exps
  '(
    (define (distinct? items)
      (cond ((null? items) true)
            ((null? (cdr items)) true)
            ((member (car items) (cdr items)) false)
            (else (distinct? (cdr items)))))

    (define (multiple-dwelling)
      (let ((baker    (amb 1 2 3 4 5))
            (cooper   (amb 1 2 3 4 5))
            (fletcher (amb 1 2 3 4 5))
            (miller   (amb 1 2 3 4 5))
            (smith    (amb 1 2 3 4 5)))
        (require
          (distinct? (list baker cooper fletcher miller smith)))
        (require (not (= baker 5)))
        (require (not (= cooper 1)))
        (require (not (= fletcher 5)))
        (require (not (= fletcher 1)))
        (require (> miller cooper))
        ; (require (not (= (abs (- smith fletcher)) 1)))
        (require (not (= (abs (- fletcher cooper)) 1)))
        (list (list 'baker baker)
              (list 'cooper cooper)
              (list 'fletcher fletcher)
              (list 'miller miller)
              (list 'smith smith))))
    (multiple-dwelling)
    try-again
    try-again
    try-again
    try-again
    try-again
    try-again
    try-again
   )
  )

(pre-eval-driver-loop exps)
; A. 5 solutions
; ;; Starting a new problem
; ;;; Amb-Eval value:
; ((baker 1) (cooper 2) (fletcher 4) (miller 3) (smith 5))
; ;;; Amb-Eval value:
; ((baker 1) (cooper 2) (fletcher 4) (miller 5) (smith 3))
; ;;; Amb-Eval value:
; ((baker 1) (cooper 4) (fletcher 2) (miller 5) (smith 3))
; ;;; Amb-Eval value:
; ((baker 3) (cooper 2) (fletcher 4) (miller 5) (smith 1))
; ;;; Amb-Eval value:
; ((baker 3) (cooper 4) (fletcher 2) (miller 5) (smith 1))
; ;;; There are no more values of
; (multiple-dwelling)

