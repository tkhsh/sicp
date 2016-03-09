# ex-4.65
## 問題
Cy D. Fect, looking forward to the day when he will rise in the organization, gives a query to find all the wheels (using the wheel rule of section 4.4.1):

````scheme
(wheel ?who)
````

To his surprise, the system responds

````scheme
;;; Query results:
(wheel (Warbucks Oliver))
(wheel (Bitdiddle Ben))
(wheel (Warbucks Oliver))
(wheel (Warbucks Oliver))
(wheel (Warbucks Oliver))
````

Why is Oliver Warbucks listed four times?
## 解答
wheelの定義は以下の通りとなっている。
````scheme
(rule (wheel ?person)
      (and (supervisor ?middle-manager ?person)
           (supervisor ?x ?middle-manager)))
````
以下、`(wheel ?who)`がどのように評価されるか順をおって見てゆく。

まず規則本体が評価され、`?person`に`?who`が束縛される。
次に`(supervisor ?middle-manager ?person)`が評価される。マッチは、データベースにあるすべてのsupervisorの表明で成功し、フレームが拡張される。
データベースにあるsupervisorの表明は以下

````scheme
(supervisor (Hacker Alyssa P) (Bitdiddle Ben))
(supervisor (Fect Cy D) (Bitdiddle Ben))
(supervisor (Tweakit Lem E) (Bitdiddle Ben))
(supervisor (Reasoner Louis) (Hacker Alyssa P))
(supervisor (Bitdiddle Ben) (Warbucks Oliver))
(supervisor (Scrooge Eben) (Warbucks Oliver))
(supervisor (Cratchet Robert) (Scrooge Eben))
(supervisor (Aull DeWitt) (Warbucks Oliver))
````

`and`で組み合わせられているため、`(supervisor ?x ?middle-manager)`は上記で拡張されたフレームで評価される。つまり、`?middle-manager`は拡張フレームに束縛が存在する状態で評価される。
マッチに成功する際の`?middle-manager`と`?x`の束縛は以下のようになる。

| ?x                | ?middle-mangager  |
|:------------------|:------------------|
| (Hacker Alyssa P) | (Bitdiddle Ben)   |
| (Fect Cy D)       | (Bitdiddle Ben)   |
| (Tweakit Lem E)   | (Bitdiddle Ben)   |
| (Reasoner Louis)  | (Hacker Alyssa P) |
| (Cratchet Robert) | (Scrooge Eben)    |

この表に`?person`の束縛も追加すると以下のようになる。

| ?x                | ?middle-mangager  | ?person           |
|:------------------|:------------------|:------------------|
| (Hacker Alyssa P) | (Bitdiddle Ben)   | (Warbucks Oliver) |
| (Fect Cy D)       | (Bitdiddle Ben)   | (Warbucks Oliver) |
| (Tweakit Lem E)   | (Bitdiddle Ben)   | (Warbucks Oliver) |
| (Reasoner Louis)  | (Hacker Alyssa P) | (Bitdiddle Ben)   |
| (Cratchet Robert) | (Scrooge Eben)    | (Warbucks Oliver) |

`?person`に`(Warbucks Oliver)`が束縛されるパターンが4通りあるため、`(wheel ?person)`の結果として Oliver Warbucks は4回現れる。
