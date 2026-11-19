#> test:magic/recipe/battle_allowed_loop
# storage test: recipe_battle.queue (要素idの配列) を先頭から1つずつ読み、
# test:magic/recipe/battle_allowed_element へ渡して#recipe_battle_ok test.temporaryを更新する

execute unless data storage test: recipe_battle.queue[0] run return 0
data modify storage test: recipe_battle.id set from storage test: recipe_battle.queue[0]
data remove storage test: recipe_battle.queue[0]
function test:magic/recipe/battle_allowed_element with storage test: recipe_battle
function test:magic/recipe/battle_allowed_loop
