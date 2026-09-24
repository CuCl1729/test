#> test:battle/ui/active_skill_minecart_resolve
# @s = アクティブスキルを取ったプレイヤー(トロッコ式)。@macro index: 取られたスロット番号
# battle.temporary.active_skill_slot[index]を見て発動する(skill_effect_minecart_resolveと同じく、
# 発動前にカートと「スキル」アイテム自体を片付ける。hover_tickの追従はもう不要なため)

data modify storage test: registry_work.active_resolve_entry set value {kind:""}
$data modify storage test: registry_work.active_resolve_entry set from storage test: battle.temporary.active_skill_slot[$(index)]

execute as @e[tag=active_skill_minecart,distance=..3] run data remove entity @s Items
kill @e[tag=active_skill_minecart,distance=..3]

clear @s minecraft:blaze_powder[custom_data~{test:{battle_action:"skill"}}]

execute if data storage test: registry_work.active_resolve_entry{kind:"sword"} run function test:battle/action/job_skill/sword_cast
execute if data storage test: registry_work.active_resolve_entry{kind:"job"} run function test:battle/action/job_skill_cast with storage test: registry_work.active_resolve_entry
