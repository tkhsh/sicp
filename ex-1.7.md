# 問題
The good-enough? test used in computing square roots will not be very effective for finding the square roots of very small numbers. Also, in real computers, arithmetic operations are almost always performed with limited precision. This makes our test inadequate for very large numbers. Explain these statements, with examples showing how the test fails for small and large numbers. An alternative strategy for implementing good-enough? is to watch how guess changes from one iteration to the next and to stop when the change is a very small fraction of the guess. Design a square-root procedure that uses this kind of end test. Does this work better for small and large numbers?

# 解答
## 平方根を求めたい数が小さすぎる場合
推測が十分な精度になる前にgood-enoughをパスしてしまう。

0.0002の平方根は 0.014142135623731 だが、sqrt関数の結果は 0.03335281609280434 となってしまう。

## 平方根をもとめたい数が大きすぎる場合
good-enough? 内でsquareを実行した時にオーバーフローしてしまう。

## good-enough?の別の実装
ex-1.7.scm に記載
