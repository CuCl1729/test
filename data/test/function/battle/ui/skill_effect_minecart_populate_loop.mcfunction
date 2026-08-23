#> test:battle/ui/skill_effect_minecart_populate_loop
# @s = 効果選択中のプレイヤー。表示条件を満たす効果だけを空きスロットへ順に詰める

execute unless data storage test: registry_work.effect_queue[-1] run return 0

data modify storage test: registry_work.effect_entry set from storage test: registry_work.effect_queue[-1]
data remove storage test: registry_work.effect_queue[-1]

function test:battle/ui/skill_effect_visible with storage test: registry_work.effect_entry
execute if score #effect_visible test.temporary matches 1 store result storage test: registry_work.effect_entry.slot int 1 run scoreboard players get #effect_slot test.temporary
execute if score #effect_visible test.temporary matches 1 run function test:battle/ui/skill_effect_minecart_populate_slot with storage test: registry_work.effect_entry

function test:battle/ui/skill_effect_minecart_populate_loop
