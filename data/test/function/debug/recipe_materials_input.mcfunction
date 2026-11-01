#> test:debug/recipe_materials_input
# @s = プレイヤー。debug_work.iq([{kind, id, count}])を1件ずつ渡す

execute unless data storage test: debug_work.iq[0] run return 0
function test:debug/recipe_materials_give with storage test: debug_work.iq[0]
data remove storage test: debug_work.iq[0]
function test:debug/recipe_materials_input
