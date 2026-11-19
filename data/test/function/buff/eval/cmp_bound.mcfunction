#> test:buff/eval/cmp_bound
# a2..a12(大きさ)とc0..c4(境界の桁)を非破壊で比較する。差を取って繰り上げ処理に通し、
# 最上位桁が負なら「以下」、0以上かつどれかの桁が非0なら「真に超える」

scoreboard players operation #be_b2 test.buff.work = #be_a2 test.buff.work
scoreboard players operation #be_b3 test.buff.work = #be_a3 test.buff.work
scoreboard players operation #be_b4 test.buff.work = #be_a4 test.buff.work
scoreboard players operation #be_b5 test.buff.work = #be_a5 test.buff.work
scoreboard players operation #be_b6 test.buff.work = #be_a6 test.buff.work
scoreboard players operation #be_b7 test.buff.work = #be_a7 test.buff.work
scoreboard players operation #be_b8 test.buff.work = #be_a8 test.buff.work
scoreboard players operation #be_b9 test.buff.work = #be_a9 test.buff.work
scoreboard players operation #be_b10 test.buff.work = #be_a10 test.buff.work
scoreboard players operation #be_b11 test.buff.work = #be_a11 test.buff.work
scoreboard players operation #be_b12 test.buff.work = #be_a12 test.buff.work

scoreboard players operation #be_a2 test.buff.work -= #be_c0 test.buff.work
scoreboard players operation #be_a3 test.buff.work -= #be_c1 test.buff.work
scoreboard players operation #be_a4 test.buff.work -= #be_c2 test.buff.work
scoreboard players operation #be_a5 test.buff.work -= #be_c3 test.buff.work
scoreboard players operation #be_a6 test.buff.work -= #be_c4 test.buff.work

function test:buff/eval/propagate

scoreboard players set #be_nz test.buff.work 0
execute unless score #be_a2 test.buff.work matches 0 run scoreboard players set #be_nz test.buff.work 1
execute unless score #be_a3 test.buff.work matches 0 run scoreboard players set #be_nz test.buff.work 1
execute unless score #be_a4 test.buff.work matches 0 run scoreboard players set #be_nz test.buff.work 1
execute unless score #be_a5 test.buff.work matches 0 run scoreboard players set #be_nz test.buff.work 1
execute unless score #be_a6 test.buff.work matches 0 run scoreboard players set #be_nz test.buff.work 1
execute unless score #be_a7 test.buff.work matches 0 run scoreboard players set #be_nz test.buff.work 1
execute unless score #be_a8 test.buff.work matches 0 run scoreboard players set #be_nz test.buff.work 1
execute unless score #be_a9 test.buff.work matches 0 run scoreboard players set #be_nz test.buff.work 1
execute unless score #be_a10 test.buff.work matches 0 run scoreboard players set #be_nz test.buff.work 1
execute unless score #be_a11 test.buff.work matches 0 run scoreboard players set #be_nz test.buff.work 1
execute unless score #be_a12 test.buff.work matches 0 run scoreboard players set #be_nz test.buff.work 1

scoreboard players set #be_gt test.buff.work 0
execute if score #be_a12 test.buff.work matches 0.. if score #be_nz test.buff.work matches 1 run scoreboard players set #be_gt test.buff.work 1

scoreboard players operation #be_a2 test.buff.work = #be_b2 test.buff.work
scoreboard players operation #be_a3 test.buff.work = #be_b3 test.buff.work
scoreboard players operation #be_a4 test.buff.work = #be_b4 test.buff.work
scoreboard players operation #be_a5 test.buff.work = #be_b5 test.buff.work
scoreboard players operation #be_a6 test.buff.work = #be_b6 test.buff.work
scoreboard players operation #be_a7 test.buff.work = #be_b7 test.buff.work
scoreboard players operation #be_a8 test.buff.work = #be_b8 test.buff.work
scoreboard players operation #be_a9 test.buff.work = #be_b9 test.buff.work
scoreboard players operation #be_a10 test.buff.work = #be_b10 test.buff.work
scoreboard players operation #be_a11 test.buff.work = #be_b11 test.buff.work
scoreboard players operation #be_a12 test.buff.work = #be_b12 test.buff.work
