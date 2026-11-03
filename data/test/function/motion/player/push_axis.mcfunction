#> test:motion/player/push_axis
# @s = プレイヤー。@macro tag: 視点の軸の目印 / out: 結果を入れるスコア。
# 目印 − 原点(×1000)= その軸の単位ベクトル。速度(#motion test.X0/Y0/Z0)との内積を @s の out に入れる
$execute store result score #push_ax test.temporary run data get entity @n[type=marker,tag=$(tag)] Pos[0] 1000
$execute store result score #push_ay test.temporary run data get entity @n[type=marker,tag=$(tag)] Pos[1] 1000
$execute store result score #push_az test.temporary run data get entity @n[type=marker,tag=$(tag)] Pos[2] 1000
scoreboard players operation #push_ax test.temporary -= #push_ox test.temporary
scoreboard players operation #push_ay test.temporary -= #push_oy test.temporary
scoreboard players operation #push_az test.temporary -= #push_oz test.temporary
scoreboard players operation #push_ax test.temporary *= #motion test.X0
scoreboard players operation #push_ay test.temporary *= #motion test.Y0
scoreboard players operation #push_az test.temporary *= #motion test.Z0
scoreboard players operation #push_ax test.temporary += #push_ay test.temporary
scoreboard players operation #push_ax test.temporary += #push_az test.temporary
scoreboard players operation #push_ax test.temporary /= #1000 test.constant
$scoreboard players operation @s $(out) = #push_ax test.temporary
