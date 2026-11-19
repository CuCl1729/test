#> test:buff/actor/stat_one
# 内部。@s = 対象。@macro stat: ステータス名。#ba_mode が
#   0: buff_actor.passives に {stat,value:<P>} を足す
#   1: buff_actor.refs.<名前> に 参照値 P + R を書く(R = test.buff.flat.<名前>。純粋な固定値の行だけの合計。
#      式の add も m の寄与も入らない)
# プレイヤーは先に装備ぶんのキャッシュを作り直す。参照値は負にもなり得るので、個別のクランプはしない。
# 作り直せない・受け身の取り分や P+R が32bitに収まらないときは #ba_err に理由(1: out_of_range /
# 2: gear_unavailable)を立てて 0 を返す(当て推量の値は公開しない)

scoreboard players set #ba_gear_ok test.buff.work 1
$execute if entity @s[type=player] store result score #ba_gear_ok test.buff.work run function test:status/gear {status:"$(stat)"}
execute if score #ba_gear_ok test.buff.work matches 0 run scoreboard players operation #ba_err test.buff.work = #gear_err test.buff.work
execute if score #ba_err test.buff.work matches 1.. run return 0

$execute store result score #ba_passive_ok test.buff.work run function test:status/passive {status:"$(stat)"}
execute if score #ba_passive_ok test.buff.work matches 0 run scoreboard players set #ba_err test.buff.work 1
execute if score #ba_err test.buff.work matches 1.. run return 0

$execute if score #ba_mode test.buff.work matches 0 run data modify storage test: buff_actor.passives append value {stat:"$(stat)",value:0}
execute if score #ba_mode test.buff.work matches 0 store result storage test: buff_actor.passives[-1].value int 1 run scoreboard players get #passive_p test.buff.work
execute if score #ba_mode test.buff.work matches 0 run return 1

# P + R。どちらも32bitなので、合計が範囲を出たら黙って折り返さずエラーにする(式の核は使わない)
data modify storage test: buff_math.arg set value {a:0,b:0,c:0}
execute store result storage test: buff_math.arg.a int 1 run scoreboard players get #passive_p test.buff.work
$execute store result storage test: buff_math.arg.b int 1 run scoreboard players get @s test.buff.flat.$(stat)
function test:buff/math/add3 with storage test: buff_math.arg
execute if score #math_ok test.buff.work matches 0 run return run scoreboard players set #ba_err test.buff.work 1

$execute store result storage test: buff_actor.refs.$(stat) int 1 run scoreboard players get #math_sum test.buff.work
return 1
