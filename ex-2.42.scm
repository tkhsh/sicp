(load "./util.scm")

(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
        (list empty-board)
        (filter
          (lambda (positions) (safe? k positions))
          (flatmap
            (lambda (rest-of-queens)
              (map (lambda (new-row)
                     (adjoin-position new-row k rest-of-queens))
                   (enumerate-interval 1 board-size)))
            (queen-cols (- k 1))))))
  (queen-cols board-size))

(define (adjoin-position new-row k rest-of-queens)
      (cons new-row rest-of-queens))

(define empty-board nil)

(define (compare-board-pair wrong-board board)
  (if (null? (filter
               (lambda (b) b)
               (map (lambda (e1 e2)
                      (if (null? e1)
                          #f
                          (= e1 e2)))
                    wrong-board
                    board)))
      #t
      #f))

(define (make-wrong-board board)
  (cons (make-board board 1)
        (cons (make-board board 0)
              (cons (make-board board -1) nil))))

(define (make-board-from-y y rest n)
  (if (null? rest)
      nil
      (cons (+ y n) (make-board-from-y (+ y n) (cdr rest) n))))
(define (make-board board n)
  (if (null? board)
      nil
      (cons nil (make-board-from-y (car board) (cdr board) n))))

(define (safe? k positions)
  (let ((wrong-board (make-wrong-board positions)))
    (and (compare-board-pair (car wrong-board) positions)
         (compare-board-pair (cadr wrong-board) positions)
         (compare-board-pair (caddr wrong-board) positions))))

(print (queens 4))
