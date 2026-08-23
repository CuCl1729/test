#> test:battle/ui/skill_effect_categories_type
# @macro id: タイプid。選択中ならそのタイプが受け付けるcategoryを1件ずつフラグへ立てる

$execute unless data storage test: registry_work.combo.type_flags{$(id):1b} run return 0

$data modify storage test: registry_work.category_queue set from storage test: asset.magic.types[{id:"$(id)"}].effect_categories
function test:battle/ui/skill_effect_categories_cat_loop
