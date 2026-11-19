#> test:status/gear/ex_ref
# 内部。storage test: status_gear.ex.refs の値を一つずつ取り出し、ex.pct の係数ぶんの項を作る
# (項は buff_eval.arg へ。参照名は r1 から通し番号)。0 の部品は項を作らない(無駄な項を増やさない)
execute unless data storage test: status_gear.ex.refs[0] run return 0
data modify storage test: status_gear.ex.v set from storage test: status_gear.ex.refs[0]
data remove storage test: status_gear.ex.refs[0]
scoreboard players add #gear_i test.buff.work 1
execute store result storage test: status_gear.ex.i int 1 run scoreboard players get #gear_i test.buff.work
data modify storage test: status_gear.ex.p set from storage test: status_gear.ex.pct
execute store result score #gear_t test.buff.work run data get storage test: status_gear.ex.v
execute unless score #gear_t test.buff.work matches 0..0 run function test:status/gear/ex_pct
function test:status/gear/ex_ref
