#> test:machine/place_core
# @s = 機械のマーカー(核の中心)。@macro id: 機械の種類。核のブロックを置き、番号(test.machine.id。ゴーストの持ち主の目印)を振り、
# 頭上の表示(text_display、tag=machine_label)を付ける

$execute unless data storage test: asset.machine.$(id) run return run function test:machine/place_fail {id:"$(id)"}
$data modify storage test: machine_work.def set from storage test: asset.machine.$(id)
execute at @s run function test:machine/place_core_block with storage test: machine_work.def
function test:machine/assign_id
scoreboard players set @s test.machine.fuel 0
scoreboard players set @s test.machine.progress 0
scoreboard players set @s test.machine.out_rr 0

# 前の表示を消してから付け直す(debug/spawn_machine で同じ所に置き直したときなど)。
# 高さは核の中心から。機械の上面は +1.5
execute on passengers run kill @s
execute at @s run summon text_display ~ ~ ~ {Tags:["machine_label","machine_label_new"],billboard:"vertical",brightness:{sky:15,block:15},transformation:{translation:[0.0f,1.9f,0.0f],scale:[1.0f,1.0f,1.0f],left_rotation:[0.0f,0.0f,0.0f,1.0f],right_rotation:[0.0f,0.0f,0.0f,1.0f]},text:{text:""}}
tag @s add machine_placing
execute as @e[tag=machine_label_new] run ride @s mount @n[tag=machine_placing]
tag @e[tag=machine_label_new] remove machine_label_new
tag @s remove machine_placing
