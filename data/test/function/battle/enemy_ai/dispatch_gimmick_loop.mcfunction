#> test:battle/enemy_ai/dispatch_gimmick_loop
# enemy_ai_work.dispatch_queue(候補のコピー)を末尾から取り出し、#rollがその重み以下なら
# そのギミックを実行して打ち切る。そうでなければ重みぶん#rollを減らして次へ進む

execute unless data storage test: enemy_ai_work.dispatch_queue[-1] run return 0

data modify storage test: enemy_ai_work.dispatch_entry set from storage test: enemy_ai_work.dispatch_queue[-1]
data remove storage test: enemy_ai_work.dispatch_queue[-1]

scoreboard players set #gw test.buff.work 0
execute store result score #gw test.buff.work run data get storage test: enemy_ai_work.dispatch_entry.weight

execute if score #roll test.buff.work <= #gw test.buff.work run function test:battle/enemy_ai/act_gimmick with storage test: enemy_ai_work.dispatch_entry
execute if score #roll test.buff.work <= #gw test.buff.work run return 0

scoreboard players operation #roll test.buff.work -= #gw test.buff.work

function test:battle/enemy_ai/dispatch_gimmick_loop
