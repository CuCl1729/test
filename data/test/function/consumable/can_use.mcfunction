#> test:consumable/can_use
# @s = 使う人。@macro id: 消耗品のid。今使って意味があれば1、無ければ0を返す(0ならアイテムを減らさない)。
# 蘇生(revive)は、起こす相手がいなければ0。ほかの効果はいつでも1

$execute unless data storage test: asset.consumable.$(id).effect{kind:"revive"} run return 1
$execute store result score #revive_found test.temporary run function test:status/revive_pick with storage test: asset.consumable.$(id).effect.params
tag @a remove revive_target
return run scoreboard players get #revive_found test.temporary
