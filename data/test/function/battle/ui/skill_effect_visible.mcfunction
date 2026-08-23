#> test:battle/ui/skill_effect_visible
# @s = 詠唱中のプレイヤー(#oh_my_dat:pleaseは呼び出し元で実行済み)
# @macro id/category: レジストリの1件ぶん(requires_typeは任意)
# その効果をUIに出すかどうかを #effect_visible test.temporary に0/1で返す。条件は
#   習得済み / 選択中のタイプが受け付けるcategory / requires_typeがあればそのタイプも選択中

scoreboard players set #effect_visible test.temporary 0

$execute unless data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.magic.known{$(id):1b} run return 0
$execute unless data storage test: registry_work.combo.categories{$(category):1b} run return 0

# requires_typeが指定されている場合はそのタイプが選ばれているかも見る(未指定なら無条件で通す)
scoreboard players set #effect_requires test.temporary 0
$execute if data storage test: asset.magic.effects[{id:"$(id)"}].requires_type run scoreboard players set #effect_requires test.temporary 1

execute if score #effect_requires test.temporary matches 0 run scoreboard players set #effect_visible test.temporary 1
execute if score #effect_requires test.temporary matches 1 run function test:battle/ui/skill_effect_visible_requires with storage test: registry_work.effect_entry
