# ex-4.64
## 問題
Louis Reasoner mistakenly deletes the outranked-by rule (section 4.4.1) from the data base. When he realizes this, he quickly reinstalls it. Unfortunately, he makes a slight change in the rule, and types it in as

````lisp
(assert! (rule (outranked-by ?staff-person ?boss)
           (or (supervisor ?staff-person ?boss)
               (and (outranked-by ?middle-manager ?boss)
                    (supervisor ?staff-person
                                ?middle-manager)))))
````

Just after Louis types this information into the system, DeWitt Aull comes by to find out who outranks Ben Bitdiddle. He issues the query

After answering, the system goes into an infinite loop. Explain why.

````lisp
(outranked-by (Bitdiddle Ben) ?who)
````

## 解答
無限ループに陥る式を評価しようとした際、以下のように評価される。
まず?staff-personに(Bitdiddle Ben)が束縛され、?bossに?whoが束縛される。
このフレームで(supervisor ?staff-person ?boss)と(outranked-by ?middle-manager ?boss)を評価する。
後者の式でoutranked-byをもう一度評価する際に?staff-personには?middle-manager、?bossには?whoが束縛されます。

outranked-byの中で再起的に自身を呼びだしているが、この呼び出しが終了することはないため無限ループに陥っている。

### メモ
Louisが書き換えたoutranked-byの元の定義は以下

````lisp
(rule (outranked-by ?staff-person ?boss)
      (or (supervisor ?staff-person ?boss)
          (and (supervisor ?staff-person ?middle-manager)
               (outranked-by ?middle-manager ?boss))))
````
