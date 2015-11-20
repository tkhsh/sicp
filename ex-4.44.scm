(load "./sec-4.3.scm")

(define exps
  '(
    (define (queens board-size)
      (define (queen-cols k board)
        (if (= k 0)
          board
          (let ((new-position (an-integer-between 1 board-size)))
            (let ((wrong-boards (make-wrong-boards new-position board)))
              (require (not (conflict? (car wrong-boards) board)))
              (require (not (conflict? (car (cdr wrong-boards)) board)))
              (require (not (conflict? (car (cdr (cdr wrong-boards))) board)))
              (queen-cols (- k 1) (cons new-position board))))))
      (queen-cols board-size '()))

    (define (make-wrong-boards new-position board)
      (list (make-board-from-y new-position board 1)
            (make-board-from-y new-position board 0)
            (make-board-from-y new-position board -1)))

    (define (make-board-from-y y rest n)
      (if (null? rest)
        '()
        (cons (+ y n) (make-board-from-y (+ y n) (cdr rest) n))))

    (define (conflict? wrong-board board)
      (if (null? wrong-board)
        false
        (if (= (car wrong-board) (car board))
          true
          (conflict? (cdr wrong-board) (cdr board)))))

    (queens 4)
    ; try-again
    ; try-again
    )
  )
(pre-eval-driver-loop exps)

