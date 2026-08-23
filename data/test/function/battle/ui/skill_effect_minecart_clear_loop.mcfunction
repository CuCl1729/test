#> test:battle/ui/skill_effect_minecart_clear_loop
# @s = 詠唱を確定したプレイヤー。効果アイコンを1件ずつ手元から消す

execute unless data storage test: registry_work.effect_queue[-1] run return 0

data modify storage test: registry_work.effect_entry set from storage test: registry_work.effect_queue[-1]
data remove storage test: registry_work.effect_queue[-1]

function test:battle/ui/skill_effect_minecart_clear_item with storage test: registry_work.effect_entry

function test:battle/ui/skill_effect_minecart_clear_loop
