#> test:buff/fire_loop
# storage test: buff_work.fire に溜まったイベントを先頭から順に発火する。
# fireは「誰でも積んでよい共有のキュー」として扱い、途中でリセットしない。こうしておくと
# イベント関数の中からbuff/applyやbuff/clearが呼ばれて入れ子でfire_loopが走っても、
# 外側のイベントが消えたり二重に発火したりしない(内側がまとめて処理し、外側は空を見て止まる)

execute unless data storage test: buff_work.fire[0] run return 0

data modify storage test: buff_work.ev set from storage test: buff_work.fire[0]
data remove storage test: buff_work.fire[0]

function test:buff/fire_entry with storage test: buff_work.ev

function test:buff/fire_loop
