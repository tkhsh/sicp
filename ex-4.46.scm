; 我々の構文解析器は文を先頭から解析していくつくりになっている。
; そのため、名詞句の解析処理と動詞句の解析処理の呼ばれる順番は常に
; 名詞句解析 -> 動詞句解析
; でなければいけないため。

; 具体的には '(the cat eats) という文を解析しようとした場合
; *unparsed*に(the cat eats)がセットされた後
;
; (define (parse-sentence)
;   (list 'sentence (parse-noun-phrase) (parse-verb-phrase)))
;
; 上記のparse-sentenceが呼ばれる。
; もしamb評価器が被演算子を右から左に評価することになっていた場合
; (parse-verb-phrase)が先によばれることになるが
; (the cat eats)の解析は失敗する。
; その後(parse-noun-phrase)が呼ばれると the cat の部分は解析できるが
; eatsは解析されることはない。
; 結果として*unparsed*にeatsが残っているため、解析に失敗する。
; この結果は我々の意図しない動作である。

