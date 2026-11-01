#> test:debug/recipe_list_one
# @s = プレイヤー。@macro id: レシピのid

$data modify storage test: debug_work.rl set from storage test: asset.recipe.$(id)
data modify storage test: debug_work.rl.st set value "作れる"
execute if data storage test: debug_work.rl.locked run data modify storage test: debug_work.rl.st set value "未研究"
$execute if data storage test: debug_work.rl.locked if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.unlock.recipe.$(id) run data modify storage test: debug_work.rl.st set value "研究済み"
function test:debug/recipe_list_line with storage test: debug_work.rl
