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
        (require (not (= (abs (- smith fletcher)) 1)))
        (require (not (= (abs (- fletcher cooper)) 1)))
        (list (list 'baker baker)
              (list 'cooper cooper)
              (list 'fletcher fletcher)
              (list 'miller miller)
              (list 'smith smith))))

    (define (efficient-multiple-dwelling)
      (let ((fletcher (amb 1 2 3 4 5)))
        (require (not (= fletcher 5)))
        (require (not (= fletcher 1)))
        (let ((cooper (amb 1 2 3 4 5)))
          (require (not (= cooper 1)))
          (require (not (= (abs (- fletcher cooper)) 1)))
          (let ((smith (amb 1 2 3 4 5)))
            (require (not (= (abs (- smith fletcher)) 1)))
            (let ((miller (amb 1 2 3 4 5)))
              (require (> miller cooper))
              (let ((baker (amb 1 2 3 4 5)))
                (require (not (= baker 5)))
                (require
                  (distinct? (list baker cooper fletcher miller smith)))
                (list (list 'baker baker)
                      (list 'cooper cooper)
                      (list 'fletcher fletcher)
                      (list 'miller miller)
                      (list 'smith smith))))))))
    (efficient-multiple-dwelling)
   )
  )
(pre-eval-driver-loop exps)

; Q. how many sets of assignments are there of people to floors,
;    both before and after the requirement that floor assignments be distinct?
; A. before:119 sets, after: 1 set
