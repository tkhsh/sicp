(load "./natural_language.scm")

(define exps
  '(
    ; (define (parse-verb-phrase)
    ;   (define (maybe-extend verb-phrase)
    ;     (amb verb-phrase
    ;          (maybe-extend
    ;            (list 'verb-phrase
    ;                  verb-phrase
    ;                  (parse-prepositional-phrase)))))
    ;   (maybe-extend (parse-word verbs)))

    ; Louis version
    (define (parse-verb-phrase)
      (amb (parse-word verbs)
           (list 'verb-phrase
                 (parse-verb-phrase)
                 (parse-prepositional-phrase))))
    (parse '(the professor lectures to the student))
    )
  )
(pre-eval-driver-loop exps)


; ex-4.47動かない。
; Louisの版では、最初の(parse-word verbs)の選択後に必ずparse-verb-phraseを再起的に呼び出す。
; 終了条件がない再起のため、プログラムが終了しない。

; 2回目以降のparse-verb-phraseの再起呼び出しで
; (list 'verb-phrase
;       (parse-verb-phrase)
;       (parse-prepositional-phrase))
; 上記の式を評価する際
; (parse-verb-phrase)で再起呼び出し
; -> <呼び出し先>(parse-word verbs)で値を選択 -> 呼び出し元に戻る
; -> <呼び出し元>(parse-prepositional-phrase)が失敗
; -> <呼び出し先>(list 'verb-phrase ...)内で再び(parse-verb-phrase)を再起呼び出し
; という流れで無限にparse-verb-phraseを呼び出し続ける
;
; Q. amb内の式の順番を変えた場合、プログラムの動作は変わるか？
; A. 変わる。ambは内部の式を評価していくが
;    式が"失敗"した時点でバックトラックをするため式の評価順によってambの動作が変わる。
