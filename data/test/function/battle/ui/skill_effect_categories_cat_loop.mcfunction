#> test:battle/ui/skill_effect_categories_cat_loop
# category名を1件ずつ取り出してフラグへ立てる

execute unless data storage test: registry_work.category_queue[-1] run return 0

data modify storage test: registry_work.category_id set from storage test: registry_work.category_queue[-1]
data remove storage test: registry_work.category_queue[-1]

function test:battle/ui/skill_effect_categories_cat with storage test: registry_work

function test:battle/ui/skill_effect_categories_cat_loop
