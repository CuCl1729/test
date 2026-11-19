#> test:magic/recipe/battle_allowed
# @macro recipe: 信頼済みレジストリID。asset.action.recipes.<recipe>.build の全要素が今の
# asset.magic.types/effects に存在し、該当する宣言のどれにもbattle:0bが無ければ1を返す。
# 手番でのタイプ・効果選択可否だけを見る判定で、組み合わせの妥当性は既存のtest:magic/recipe/compileが別途判定する

data remove storage test: recipe_battle

$execute unless data storage test: asset.action.recipes.$(recipe).build[0] run return 0

scoreboard players set #recipe_battle_ok test.temporary 1
$data modify storage test: recipe_battle.queue set from storage test: asset.action.recipes.$(recipe).build
function test:magic/recipe/battle_allowed_loop

return run scoreboard players get #recipe_battle_ok test.temporary
