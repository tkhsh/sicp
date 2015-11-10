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
        (require (not (= baker 5)))
        (require (not (= cooper 1)))
        (require (not (= fletcher 5)))
        (require (not (= fletcher 1)))
        (require (> miller cooper))
        (require (not (= (abs (- fletcher cooper)) 1)))
        (require (not (= (abs (- smith fletcher)) 1)))
        (require
          (distinct? (list baker cooper fletcher miller smith)))
        (list (list 'baker baker)
              (list 'cooper cooper)
              (list 'fletcher fletcher)
              (list 'miller miller)
              (list 'smith smith))))
    (multiple-dwelling)
   )
  )
(pre-eval-driver-loop exps)

; multiple-dwelling内の制約の順番は解に影響しない。
; 答えを見つける順番には影響する。
; requireの条件式で、処理が重いものを最後に実行することで
; 重い条件式が実行される回数が減る。
; multiple-dwellingの場合、distinct?の処理が比較的重いので
; 一番最後に実施することで最初の版より少し軽くなるかもしれない。
; (cf. 上記のmultiple-dwelling)

; ただし、requireの順番を変えたところで探索する可能性の数は減らない。
; distinct?はmultiple-dwellingのrequireの条件式の中では一番重いと思われるが
; 明らかにパフォーマンスに影響がでるほど重い処理ではないため、
; 探索する可能性の数を減らすチューニングを行ったほうが効果的。
