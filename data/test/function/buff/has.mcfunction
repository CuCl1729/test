#> test:buff/has
# @s = 対象。@macro id: 調べるバフid
# 掛かっているかどうかを #buff_has test.buff.work に 0/1 で返す

function test:buff/load

scoreboard players set #buff_has test.buff.work 0
$execute if data storage test: buff_work.list[{id:"$(id)"}] run scoreboard players set #buff_has test.buff.work 1
