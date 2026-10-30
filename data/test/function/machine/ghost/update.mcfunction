#> test:machine/ghost/update
# @s = 機械のマーカー(実行位置は核の中心。#machine_owner = この機械の番号)。足りない位置(machine_work.missing)に
# ゴースト(block_display、tag=machine_ghost、test.machine.id が持ち主の番号)を出し、埋まった位置のものは消す。
# 近くに人がいなければ全部消す。見せるブロックは見つかった筐体の種類(無ければ asset.casing_ids の最初)。種類が変わったら作り直す

data modify storage test: machine_work.ghost_casing set from storage test: machine_work.casing
execute if data storage test: machine_work{casing:""} run data modify storage test: machine_work.ghost_casing set from storage test: asset.casing_ids[0]
execute store success score #ghost_changed test.temporary run data modify entity @s data.machine.ghost set from storage test: machine_work.ghost_casing
execute if score #ghost_changed test.temporary matches 1 run function test:machine/ghost/clear
execute if score #machine_viewer test.temporary matches 0 run return run function test:machine/ghost/clear

# 持ち主の全部のゴーストに印を付け、足りない位置にあるものだけ印を外し、印が残ったもの(埋まった位置)を消す
execute as @e[type=block_display,tag=machine_ghost,distance=..4] if score @s test.machine.id = #machine_owner test.temporary run tag @s add machine_ghost_stale
data modify storage test: machine_work.ghost_arg set value {block:""}
function test:machine/ghost/load_block with storage test: machine_work
data modify storage test: machine_work.ghost_queue set from storage test: machine_work.missing
function test:machine/ghost/loop
kill @e[type=block_display,tag=machine_ghost_stale]
return 1
