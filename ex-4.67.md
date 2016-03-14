# ex-4.67
## 問題
Devise a way to install a loop detector in the query system so as to avoid the kinds of simple loops illustrated in the text and in exercise 4.64. The general idea is that the system should maintain some sort of history of its current chain of deductions and should not begin processing a query that it is already working on. Describe what kind of information (patterns and frames) is included in this history, and how the check should be made. (After you study the details of the query-system implementation in section 4.4.4, you may want to modify the system to include your loop detector.)
## 解答
履歴は最初は空にしておき、マッチ/ユニフィケーションを実行する度に履歴にパターンとフレームを追加する。
マッチ/ユニフィケーションを行う際には履歴をチェックして同じパターンとフレームの組み合わせで実行していないことをチェックする。

あるクエリがシステムの入力から得られて、実行されている場合、そのクエリの評価が完了したら履歴も削除する。
あるクエリ(A)が、別のクエリ(B)から呼ばれて実行されている場合、クエリAの履歴はクエリ(B)の評価が終了した時に削除する。
