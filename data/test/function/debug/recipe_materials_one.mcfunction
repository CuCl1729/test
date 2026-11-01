#> test:debug/recipe_materials_one
# @s = プレイヤー。@macro id: レシピのid。1回分の材料(asset.recipe.<id>.inputs)を渡す

$data modify storage test: debug_work.iq set from storage test: asset.recipe.$(id).inputs
function test:debug/recipe_materials_input
