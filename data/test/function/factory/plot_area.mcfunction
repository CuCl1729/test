#> test:factory/plot_area
# @macro n: 区画の番号。区画の位置を factory_work.plot = {n, x0, z0, x1, z1, floor, wall, ceil, cx, cz} にする
# (x0/z0 = 角、x1/z1 = 反対の角、floor = 床の高さ、wall = 壁の下端(床の1つ上)、ceil = 天井の高さ、cx/cz = 中心)。
# n 番目の区画の角は (n × 間隔, 0)。大きさ・間隔・高さは「定数」タブ(asset.config.factory_*)

$scoreboard players set #fp_n test.temporary $(n)
execute store result score #fp_size test.temporary run data get storage test: asset.config.factory_plot_size
execute store result score #fp_x0 test.temporary run data get storage test: asset.config.factory_plot_spacing
execute store result score #fp_floor test.temporary run data get storage test: asset.config.factory_floor_y
execute store result score #fp_ceil test.temporary run data get storage test: asset.config.factory_top_y
scoreboard players add #fp_ceil test.temporary 1

data modify storage test: factory_work.plot set value {n:0,x0:0,z0:0,x1:0,z1:0,floor:0,wall:0,ceil:0,cx:0,cz:0}
$data modify storage test: factory_work.plot.n set value $(n)
scoreboard players operation #fp_x0 test.temporary *= #fp_n test.temporary
execute store result storage test: factory_work.plot.x0 int 1 run scoreboard players get #fp_x0 test.temporary
execute store result storage test: factory_work.plot.floor int 1 run scoreboard players get #fp_floor test.temporary
execute store result storage test: factory_work.plot.wall int 1 run scoreboard players add #fp_floor test.temporary 1
execute store result storage test: factory_work.plot.ceil int 1 run scoreboard players get #fp_ceil test.temporary

# 反対の角 = 角 + 大きさ − 1、中心 = 角 + 大きさ ÷ 2
scoreboard players operation #fp_x1 test.temporary = #fp_x0 test.temporary
scoreboard players operation #fp_x1 test.temporary += #fp_size test.temporary
execute store result storage test: factory_work.plot.x1 int 1 run scoreboard players remove #fp_x1 test.temporary 1
execute store result storage test: factory_work.plot.z1 int 1 run scoreboard players remove #fp_size test.temporary 1
scoreboard players add #fp_size test.temporary 1
scoreboard players operation #fp_half test.temporary = #fp_size test.temporary
scoreboard players operation #fp_half test.temporary /= #2 test.constant
execute store result storage test: factory_work.plot.cz int 1 run scoreboard players get #fp_half test.temporary
execute store result storage test: factory_work.plot.cx int 1 run scoreboard players operation #fp_half test.temporary += #fp_x0 test.temporary
