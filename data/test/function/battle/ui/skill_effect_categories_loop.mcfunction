#> test:battle/ui/skill_effect_categories_loop
# タイプを1件ずつ取り出し、選択中ならそのeffect_categoriesを集計へ加える

execute unless data storage test: registry_work.type_queue[-1] run return 0

data modify storage test: registry_work.type_entry set from storage test: registry_work.type_queue[-1]
data remove storage test: registry_work.type_queue[-1]

function test:battle/ui/skill_effect_categories_type with storage test: registry_work.type_entry

function test:battle/ui/skill_effect_categories_loop
