#> test:equip/proc/collect_loop
# equip_work.slot_queue(装備1つぶんの自動発動の枠のコピー)を先頭から1枠ずつ見る。#proc_idx が枠番号(0から)

execute unless data storage test: equip_work.slot_queue[0] run return 0

data modify storage test: equip_work.slot set from storage test: equip_work.slot_queue[0]
execute store result storage test: equip_work.collect_arg.idx int 1 run scoreboard players get #proc_idx test.temporary
data modify storage test: equip_work.collect_arg.part set from storage test: equip_work.part
function test:equip/proc/collect_entry with storage test: equip_work.collect_arg

data remove storage test: equip_work.slot_queue[0]
scoreboard players add #proc_idx test.temporary 1
function test:equip/proc/collect_loop
