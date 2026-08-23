#> test:battle/ui/skill_type_minecart_populate_loop
# @s = タイプ選択中のプレイヤー。習得済みのタイプだけを空きスロットへ順に詰める

execute unless data storage test: registry_work.type_queue[-1] run return 0

data modify storage test: registry_work.type_entry set from storage test: registry_work.type_queue[-1]
data remove storage test: registry_work.type_queue[-1]

execute store result storage test: registry_work.type_entry.slot int 1 run scoreboard players get #type_slot test.temporary
function test:battle/ui/skill_type_minecart_populate_slot with storage test: registry_work.type_entry

function test:battle/ui/skill_type_minecart_populate_loop
