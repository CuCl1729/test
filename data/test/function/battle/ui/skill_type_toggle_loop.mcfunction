#> test:battle/ui/skill_type_toggle_loop
# @s = タイプをトグルしたプレイヤー。クリックされた番号(#skill_select)に対応するタイプを探して切り替える

execute unless data storage test: registry_work.type_queue[-1] run return 0

data modify storage test: registry_work.type_entry set from storage test: registry_work.type_queue[-1]
data remove storage test: registry_work.type_queue[-1]

execute if score #skill_select test.battle.skill_select = #type_index test.temporary run function test:battle/ui/skill_type_toggle with storage test: registry_work.type_entry

scoreboard players add #type_index test.temporary 1
function test:battle/ui/skill_type_toggle_loop
