#> test:asset/equip/proc_roll_loop
# 作っている装備(storage test: loot.item)に、自動発動の枠を #proc_left 個付ける。
# イベントは asset.equip.proc_events の何番目かを抽選する(同じイベントが重なってもよい)

execute unless score #proc_left test.temporary matches 1.. run return 0

data modify storage test: loot.proc_roll set value {key:"equip_proc_event",min:0,max:0}
execute store result score #proc_max test.temporary run data get storage test: asset.equip.proc_events
scoreboard players remove #proc_max test.temporary 1
execute store result storage test: loot.proc_roll.max int 1 run scoreboard players get #proc_max test.temporary

execute store result storage test: loot.proc_index int 1 run function test:rng/roll with storage test: loot.proc_roll
function test:asset/equip/proc_add with storage test: loot

scoreboard players remove #proc_left test.temporary 1
function test:asset/equip/proc_roll_loop
