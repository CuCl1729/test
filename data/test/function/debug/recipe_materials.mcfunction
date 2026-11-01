#> test:debug/recipe_materials
# @s = プレイヤー。カスタムクラフターの全レシピの材料を、1回分ずつ渡す(素材は test:item/material/give、バニラは give)

data modify storage test: debug_work.give_queue set from storage test: asset.recipe_ids
function test:debug/recipe_materials_loop
