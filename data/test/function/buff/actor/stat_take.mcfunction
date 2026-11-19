#> test:buff/actor/stat_take
# 内部。work.stats(ステータス名の文字列の一覧)を1件ずつ取り、マクロ引数にできる複合へ移して stat_one を呼ぶ

execute unless data storage test: buff_actor.work.stats[0] run return 0

data modify storage test: buff_actor.work.s.stat set from storage test: buff_actor.work.stats[0]
data remove storage test: buff_actor.work.stats[0]

function test:buff/actor/stat_one with storage test: buff_actor.work.s

execute if score #ba_err test.buff.work matches 1.. run return 0
function test:buff/actor/stat_take
