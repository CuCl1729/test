#> test:magic/recipe/battle_allowed_element
# @macro id: 要素id。asset.magic.types/effectsのどちらにも無ければ、またはbattle:0bの宣言が
# あれば#recipe_battle_ok test.temporaryを0にする(既に0なら上書きしない。後続要素が許可でも失敗は失敗のまま)

scoreboard players set #recipe_battle_found test.temporary 0
$execute if data storage test: asset.magic.types[{id:"$(id)"}] run scoreboard players set #recipe_battle_found test.temporary 1
$execute if data storage test: asset.magic.effects[{id:"$(id)"}] run scoreboard players set #recipe_battle_found test.temporary 1
execute if score #recipe_battle_found test.temporary matches 0 run scoreboard players set #recipe_battle_ok test.temporary 0

$execute if data storage test: asset.magic.types[{id:"$(id)",battle:0b}] run scoreboard players set #recipe_battle_ok test.temporary 0
$execute if data storage test: asset.magic.effects[{id:"$(id)",battle:0b}] run scoreboard players set #recipe_battle_ok test.temporary 0
