# 問題
Observe that our model of evaluation allows for combinations whose operators are compound expressions. Use this observation to describe the behavior of the following procedure:

```
(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))
```

# 解答
まず、関数a-plus-abs-b に与えられたaとbの実引数で本体のa, bを置き換える.
例えば `(a-plus-abs-b 1 2)` という式を評価する際は本体の式が `((if (> 2 0) + -) 1 2)` と置き換えられる.
次に `(if (> b 0) + -)` が評価される.上記例の場合では + が戻り値として返される.
そして、+か-の関数が評価される.上記例では `(+ 1 2)` が評価され、3が式全体の結果として返される.
