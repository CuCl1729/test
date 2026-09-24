#> test:battle/ui/active_skill_minecart_populate_slot
# @s = アクティブスキル選択中のプレイヤー。@macro job/node: 職業スキル参照1件
# スロット8(確認/決定は無いので実質7件目)を超える分は諦めて飛ばす(paging未対応。populate参照)

execute if score #active_slot test.temporary matches 8.. run return 0

$function test:job/skill/load_entry {job:"$(job)",node:"$(node)"}

data modify storage test: job_work.mc_item set value {id:"nether_star",count:1,components:{"minecraft:custom_name":{text:"",italic:false,color:"light_purple"},"minecraft:custom_data":{test:{active_skill:1b}}}}
data modify storage test: job_work.mc_item.components."minecraft:custom_name".text set from storage test: job_work.skill_entry.label
execute store result storage test: job_work.mc_item.Slot byte 1 run scoreboard players get #active_slot test.temporary

data modify entity @n[tag=active_skill_minecart] Items append from storage test: job_work.mc_item

data modify storage test: battle.temporary.active_skill_slot append value {kind:"job",job:"",node:""}
$data modify storage test: battle.temporary.active_skill_slot[-1].job set value "$(job)"
$data modify storage test: battle.temporary.active_skill_slot[-1].node set value "$(node)"

scoreboard players add #active_slot test.temporary 1
