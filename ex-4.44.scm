(load "./sec-4.3.scm")

(define exps
  '(
    (define (queens board-size)
      (define (queen-cols k board)
        (if (= k 0)
          board
          (let ((new-board (cons (an-integer-between 1 board-size) board)))
            (let ((wrong-boards (make-wrong-boards new-board)))
              (require (not (conflict? (car wrong-boards) new-board)))
              (require (not (conflict? (car (cdr wrong-boards)) new-board)))
              (require (not (conflict? (car (cdr (cdr wrong-boards))) new-board)))
              (queen-cols (- k 1) new-board)))))
      (queen-cols board-size '()))

    (define (make-wrong-boards board)
      (list (cons '() (make-board-from-y (car board) (cdr board) 1))
            (cons '() (make-board-from-y (car board) (cdr board) 0))
            (cons '() (make-board-from-y (car board) (cdr board) -1))))

    (define (make-board-from-y y rest n)
      (if (null? rest)
        '()
        (cons (+ y n) (make-board-from-y (+ y n) (cdr rest) n))))

    (define (conflict? wrong-board board)
      (if (null? wrong-board)
        false
        (if (null? (car wrong-board))
          (conflict? (cdr wrong-board) (cdr board))
          (if (= (car wrong-board) (car board))
            true
            (conflict? (cdr wrong-board) (cdr board))))))

    (queens 4)
    ; try-again
    ; try-again
    )
  )
(pre-eval-driver-loop exps)

