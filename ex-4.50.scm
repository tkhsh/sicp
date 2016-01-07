(load "./natural_language.scm")
(use srfi-27)

(random-source-randomize! default-random-source)

(define (ramb? exp) (tagged-list? exp 'ramb))
(define (ramb-choices exp) (cdr exp))

(define (analyze exp)
  (cond ((self-evaluating? exp)
         (analyze-self-evaluating exp))
        ((quoted? exp) (analyze-quoted exp))
        ((variable? exp) (analyze-variable exp))
        ((assignment? exp) (analyze-assignment exp))
        ((definition? exp) (analyze-definition exp))
        ((if? exp) (analyze-if exp))
        ((lambda? exp) (analyze-lambda exp))
        ((begin? exp) (analyze-sequence (begin-actions exp)))
        ((cond? exp) (analyze (cond->if exp)))
        ((let? exp) (analyze (let->combination exp)))
        ((amb? exp) (analyze-amb exp))
        ((ramb? exp) (analyze-ramb exp)) ;; changed
        ((application? exp) (analyze-application exp))
        (else
          (error "Unknown expression type -- ANALYZE" exp))))

(define (remove-at lst n)
  (if (= n 0)
    (cdr lst)
    (cons (car lst)
          (remove-at (cdr lst) (- n 1)))))

(define (analyze-ramb exp)
  (let ((cprocs (map analyze (ramb-choices exp))))
    (lambda (env succeed fail)
      (define (try-random choices)
        (if (null? choices)
          (fail)
          (let ((rand-index (random-integer (length choices))))
            (let ((choice (list-ref choices rand-index))
                  (rest   (remove-at choices rand-index)))
              (choice env
                      succeed
                      (lambda () (try-random rest)))))))
      (try-random cprocs))))
(define exps
  '(
    (ramb 1 2 3 4)
    try-again
    try-again
    try-again
    ))
; (pre-eval-driver-loop exps)

; ex-4.49でAlyssaのアイデアを実装した際には2つの問題があった。
; 1つ目は常にparse-wordが品詞リストの中を決まった順番で選択する問題
; 2つ目はparse-wordが常に成功するため
; phraseを生成する際にmaybe-extendの再起にはまって抜け出せなくなってしまう問題
;
; 1つ目の問題に関してはparse-word内のambをrambに変えることで
; ランダムな順番で品詞を選択することになるため解決できる。
; 2つ目の問題に関してはランダムで「失敗」も選択するなrambを作成し
; parse-noun-phraseやphrase-verb-phraseのambをこの新たなrambにすることで解決できる。
; 「失敗」も選択するようなrambの実装は以下のようなものが考えられる.
; (define (analyze-ramb exp)
;   (let ((cprocs (map analyze (ramb-choices exp))))
;     (lambda (env succeed fail)
;       (define (try-random choices)
;         (if (null? choices)
;           (fail)
;           (let* ((rand-index (random-integer (+ (length choices) 1))))
;             (if (= rand-index (length choices))
;               (fail)
;               (let ((choice (list-ref choices rand-index))
;                     (rest   (remove-at choices rand-index)))
;                 (choice env
;                         succeed
;                         (lambda () (try-random rest))))))))
;       (try-random cprocs))))

(define random-sentence '(
    (define (parse-word word-list)
      (define (select-word words)
        (require (not (null? words)))
        (ramb (car words)
              (select-word (cdr words))))
      (let ((selected-word (select-word (cdr word-list))))
        (list (car word-list)
              selected-word)))
    (define (parse-noun-phrase)
      (define (maybe-extend noun-phrase)
        (ramb noun-phrase
             (maybe-extend
               (list 'noun-phrase
                     noun-phrase
                     (parse-prepositional-phrase)))))
      (maybe-extend (parse-simple-noun-phrase)))

    (define (parse-verb-phrase)
      (define (maybe-extend verb-phrase)
        (ramb verb-phrase
              (maybe-extend
                (list 'verb-phrase
                      verb-phrase
                      (parse-prepositional-phrase)))))
      (maybe-extend (parse-word verbs)))

    (parse '())
    (parse '())
    (parse '())
    (parse '())
    (parse '())
    ))
; (pre-eval-driver-loop random-sentence)
