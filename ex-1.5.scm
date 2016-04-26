# 問題

Ben Bitdiddle has invented a test to determine whether the interpreter he is faced with is using applicative-order evaluation or normal-order evaluation. He defines the following two procedures:

```
(define (p) (p))

(define (test x y)
  (if (= x 0)
      0
      y))
```

Then he evaluates the expression

```
(test 0 (p))
```

What behavior will Ben observe with an interpreter that uses applicative-order evaluation? What behavior will he observe with an interpreter that uses normal-order evaluation? Explain your answer. (Assume that the evaluation rule for the special form if is the same whether the interpreter is using normal or applicative order: The predicate expression is evaluated first and the result determines whether to evaluate the consequent or the alternative expression.)

# 解答

## applicative-orderの場合

まず、関数testの引数を評価する。
`(p)` を評価するが、無限ループに陥るため結果は返ってこない.

## normal-orderの場合

`(test 0 (p))` は `(if (= 0 0) 0 (p))` に展開される.
predicateの式 `(= 0 0)` を評価し、真となるため、0が式全体の結果となる.
