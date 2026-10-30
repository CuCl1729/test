#> test:machine/place
# @s = エッグで置かれた機械のマーカー(実行位置も@s)。ブロックの中心に合わせ、前の向きを置いた人のいる方へ90度単位で決める。
# 足元が床(#test:machine_floor)で自分の位置が空いていれば核を置き、置けなければエッグを返して消える

tag @s remove summoned
execute align xyz run tp @s ~0.5 ~0.5 ~0.5

# 向き: 置いた人(一番近いプレイヤー)の方を向き、(yaw + 405) / 90 % 4 * 90 で 0/90/180/270 に丸める
execute at @s facing entity @p feet run tp @s ~ ~ ~ ~ 0
execute store result score #machine_yaw test.temporary run data get entity @s Rotation[0]
scoreboard players add #machine_yaw test.temporary 405
scoreboard players set #machine_n test.temporary 90
scoreboard players operation #machine_yaw test.temporary /= #machine_n test.temporary
scoreboard players set #machine_n test.temporary 4
scoreboard players operation #machine_yaw test.temporary %= #machine_n test.temporary
scoreboard players set #machine_n test.temporary 90
scoreboard players operation #machine_yaw test.temporary *= #machine_n test.temporary
execute store result entity @s Rotation[0] float 1 run scoreboard players get #machine_yaw test.temporary

execute at @s unless block ~ ~-1 ~ #test:machine_floor run return run function test:machine/place_fail with entity @s data.machine
execute at @s unless block ~ ~ ~ #minecraft:air run return run function test:machine/place_fail with entity @s data.machine
function test:machine/place_core with entity @s data.machine
