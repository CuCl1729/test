#> test:magic/crafter/click_craft
# @s = クラフター本体。確定ボタンが取られた。組み合わせを検証し、成立していればアイテムを渡す
# 確定時にこの台から再計算する。別の台や詠唱処理も同じ作業領域を使うため。
# 不正な場合は素材(=中段の要素)を消費しない。既存の実装が物理素材を消費しなかったのと同じ結果にするため

function test:magic/crafter/calculate
function test:magic/crafter/validate

scoreboard players set #craft_ok test.buff.work 0
execute if data storage test: magic.loot.status.magic_type if score #combo_invalid test.temporary matches 0 run scoreboard players set #craft_ok test.buff.work 1
execute unless data entity @s data.crafter_ui.build[0] run scoreboard players set #craft_ok test.buff.work 0

execute if score #craft_ok test.buff.work matches 0 run function test:magic/crafter/failure

execute if score #craft_ok test.buff.work matches 1 run data modify storage test: loot.context set value "loot"
# つないだ魔法には通し番号を付ける(「再使用で」が、自分の置いた物のうちどの魔法のものかを見分けるため)
execute if score #craft_ok test.buff.work matches 1 if data storage test: magic.loot.status.chain[0] run scoreboard players add #magic_uid test.time 1
execute if score #craft_ok test.buff.work matches 1 if data storage test: magic.loot.status.chain[0] store result storage test: magic.loot.status.uid int 1 run scoreboard players get #magic_uid test.time
execute if score #craft_ok test.buff.work matches 1 positioned ~ ~1 ~ run function test:item/magic/give
execute if score #craft_ok test.buff.work matches 1 run function test:magic/crafter/success
execute if score #craft_ok test.buff.work matches 1 run data modify entity @s data.crafter_ui.build set value []
