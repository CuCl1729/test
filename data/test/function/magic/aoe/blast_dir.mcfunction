#> test:magic/aoe/blast_dir
# @s = 吹き飛ばす相手。実行位置 = 爆発の中心。中心から相手の足元への単位ベクトル(×1000)に #blast_power を掛けて
# #motion test.X0/Y0/Z0 に足す(Y0 には呼び出し元が lift を入れてある)。単位ベクトルは中心に出した2つの目印の差から取る
summon marker ~ ~ ~ {Tags:["blast_o"]}
execute facing entity @s feet run summon marker ^ ^ ^1 {Tags:["blast_d"]}
execute store result score #blast_ox test.temporary run data get entity @n[type=marker,tag=blast_o] Pos[0] 1000
execute store result score #blast_oy test.temporary run data get entity @n[type=marker,tag=blast_o] Pos[1] 1000
execute store result score #blast_oz test.temporary run data get entity @n[type=marker,tag=blast_o] Pos[2] 1000
execute store result score #blast_dx test.temporary run data get entity @n[type=marker,tag=blast_d] Pos[0] 1000
execute store result score #blast_dy test.temporary run data get entity @n[type=marker,tag=blast_d] Pos[1] 1000
execute store result score #blast_dz test.temporary run data get entity @n[type=marker,tag=blast_d] Pos[2] 1000
kill @e[type=marker,tag=blast_o]
kill @e[type=marker,tag=blast_d]
scoreboard players operation #blast_dx test.temporary -= #blast_ox test.temporary
scoreboard players operation #blast_dy test.temporary -= #blast_oy test.temporary
scoreboard players operation #blast_dz test.temporary -= #blast_oz test.temporary
scoreboard players operation #blast_dx test.temporary *= #blast_power test.temporary
scoreboard players operation #blast_dy test.temporary *= #blast_power test.temporary
scoreboard players operation #blast_dz test.temporary *= #blast_power test.temporary
scoreboard players operation #blast_dx test.temporary /= #1000 test.constant
scoreboard players operation #blast_dy test.temporary /= #1000 test.constant
scoreboard players operation #blast_dz test.temporary /= #1000 test.constant
scoreboard players operation #motion test.X0 += #blast_dx test.temporary
scoreboard players operation #motion test.Y0 += #blast_dy test.temporary
scoreboard players operation #motion test.Z0 += #blast_dz test.temporary
