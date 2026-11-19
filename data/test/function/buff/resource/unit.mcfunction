#> test:buff/resource/unit
# 内部。マクロ {i:<宣言された行の添字>}。rest を削りながら、選ばれた単位を1件ぶん足し込む。
# 「入る分だけ取る」飽和した引き算なので、生の合計が int32 を超えても桁あふれしない

data modify storage test: buff_resource.unit set from storage test: buff_resource.rest[0]
data remove storage test: buff_resource.rest[0]

scoreboard players set #br_v test.buff.work 0
$execute store result score #br_v test.buff.work run data get storage test: buff_resource.unit.eff.effects[$(i)].value
execute if score #br_v test.buff.work matches ..-1 run scoreboard players set #br_v test.buff.work 0
execute if score #br_v test.buff.work > #br_budget test.buff.work run scoreboard players operation #br_v test.buff.work = #br_budget test.buff.work
scoreboard players operation #br_budget test.buff.work -= #br_v test.buff.work
scoreboard players operation #br_applied test.buff.work += #br_v test.buff.work

execute if data storage test: buff_resource.rest[0] run function test:buff/resource/unit with storage test: buff_resource.arg
