#> test:battle/ui/active_skill_minecart_populate_slot
# @s = アクティブスキル選択中のプレイヤー。@macro job/node: 職業スキル参照1件
# トロッコのスロット0〜25に並べ、26件を超える分は飛ばす

execute if score #active_slot test.temporary matches 26.. run return 0
$execute store result score #job_active test.job.work run function test:job/skill/is_active {job:"$(job)",node:"$(node)"}
execute if score #job_active test.job.work matches 0 run return 0

$function test:job/skill/load_entry {job:"$(job)",node:"$(node)"}

data modify storage test: job_work.mc_item set value {id:"nether_star",count:1,components:{"minecraft:custom_name":{text:"",italic:false,color:"light_purple"},"minecraft:custom_data":{test:{active_skill:1b}}}}
data modify storage test: job_work.mc_item.components."minecraft:custom_name".text set from storage test: job_work.skill_entry.label
execute store result storage test: job_work.mc_item.Slot byte 1 run scoreboard players get #active_slot test.temporary

data modify entity @n[tag=active_skill_minecart] Items append from storage test: job_work.mc_item

data modify entity @n[tag=battle_marker,distance=..64] data.turn.active_skill_slot append value {kind:"job",job:"",node:""}
$data modify entity @n[tag=battle_marker,distance=..64] data.turn.active_skill_slot[-1].job set value "$(job)"
$data modify entity @n[tag=battle_marker,distance=..64] data.turn.active_skill_slot[-1].node set value "$(node)"

scoreboard players add #active_slot test.temporary 1
