#> test:equip/set_loop
# @s = プレイヤー。storage test: equip_work.set_queue(シリーズのレジストリのコピー)を1件ずつ見る

execute unless data storage test: equip_work.set_queue[0] run return 0

data modify storage test: equip_work.set set from storage test: equip_work.set_queue[0]
function test:equip/set_check with storage test: equip_work.set

data remove storage test: equip_work.set_queue[0]
function test:equip/set_loop
