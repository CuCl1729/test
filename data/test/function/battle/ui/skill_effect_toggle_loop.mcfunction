#> test:battle/ui/skill_effect_toggle_loop
# @s = 効果をトグルしたプレイヤー。クリックされた番号(#skill_effect)に対応する効果を探して切り替える

execute unless data storage test: registry_work.effect_queue[-1] run return 0

data modify storage test: registry_work.effect_entry set from storage test: registry_work.effect_queue[-1]
data remove storage test: registry_work.effect_queue[-1]

execute if score #skill_effect test.battle.skill_effect = #effect_index test.temporary run function test:battle/ui/skill_effect_toggle with storage test: registry_work.effect_entry

scoreboard players add #effect_index test.temporary 1
function test:battle/ui/skill_effect_toggle_loop
