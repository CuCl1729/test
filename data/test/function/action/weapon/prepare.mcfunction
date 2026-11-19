#> test:action/weapon/prepare
# @s = 武器スキルの詠唱者(所持者と同一)。手替え等の後に通常攻撃を再現するため、
# test:action/weapon/snapshot が凍結した武器ダメージ6チャンネルだけを test.*_damage に戻す。
# crit系やMPなどのステータス表示スコアは書き換えない(UIがずれるため)。
# magic.player.data.action が武器の記録でなければ何もせず return 0(通常の呪文詠唱経路)。

execute unless data storage test: magic.player.data.action{kind:"weapon"} run return 0

execute store result score @s test.fire_damage run data get storage test: magic.player.data.action.damage.fire
execute store result score @s test.water_damage run data get storage test: magic.player.data.action.damage.water
execute store result score @s test.wood_damage run data get storage test: magic.player.data.action.damage.wood
execute store result score @s test.metal_damage run data get storage test: magic.player.data.action.damage.metal
execute store result score @s test.earth_damage run data get storage test: magic.player.data.action.damage.earth
execute store result score @s test.physics_damage run data get storage test: magic.player.data.action.damage.physics

return 1
