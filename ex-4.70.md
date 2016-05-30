# 問題
 What is the purpose of the let bindings in the procedures add-assertion! and add-rule! ? What would be wrong with the following implementation of add-assertion! ? Hint: Recall the definition of the infinite stream of ones in section 3.5.2: (define ones (cons-stream 1 ones)).

```
(define (add-assertion! assertion)
  (store-assertion-in-index assertion)
  (set! THE-ASSERTIONS
        (cons-stream assertion THE-ASSERTIONS))
  'ok)
```

# 解答
`(cons-stream A B)` は B の評価が遅延される。
上記のadd-assertion!ではTHE-ASSERTIONSに最初の要素がassertionでそれ以降がTHE-ASSERTIONSであるストリームが束縛される。このストリームの2番目の要素を取得する際は、THE-ASSERTIONSの最初の要素が評価され、assertionが返される。3番目以降の要素を取得する際も同様にassertionが返される。
`add-assertion!` ではこのような動作は意図とは違っているため、間違い。
