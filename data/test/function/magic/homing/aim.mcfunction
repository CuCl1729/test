#> test:magic/homing/aim
# @s = 持ち主。実行位置 = 発生源(設置物・弾)の位置。@macro radius: 探す距離。
# 発生源から見て一番近い狙える敵に homing_target を付け、見つかれば 1 を返す。
# 使う側は execute facing entity @e[tag=homing_target,limit=1] でその方へ向ける
tag @e remove homing_target
scoreboard players set #homing_found test.temporary 0
$execute as @e[tag=enemy,tag=!battle_member,scores={test.status.hp=1..},distance=..$(radius),sort=nearest,limit=1] run function test:magic/homing/aim_mark
return run scoreboard players get #homing_found test.temporary
