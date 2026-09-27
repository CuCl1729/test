#> test:scan/aoe/
# @s = 攻撃者(実行位置は毎回positioned ^ ^ ^1で1歩ずつ前進済み)。ray_cast/と同じ「歩きながらヒットボックスに
# 触れたら`hit`」方式だが、判定ボックスの左右幅(dx/dz)を距離×tan(半角)で広げていくことで扇形にする。
# #aoe_half_angle/#aoe_reach(いずれもtest.temporary)は呼び出し元(attack/aoe)で設定済み

scoreboard players remove @s test.repeat 1

scoreboard players operation #aoe_dist test.temporary = #aoe_reach test.temporary
scoreboard players operation #aoe_dist test.temporary -= @s test.repeat

# tan(半角)×100をcomputeで求める(定義はcontext_float_provider/scan/aoe_tan)
execute store result score #aoe_width test.temporary run compute default float test:scan/aoe_tan 100
scoreboard players operation #aoe_width test.temporary *= #aoe_dist test.temporary

execute store result storage test: scan.aoe.width double 0.01 run scoreboard players get #aoe_width test.temporary
# ray_cast由来の固定値0.5を下限にクランプし、近距離での取りこぼしを防ぐ
execute if score #aoe_width test.temporary matches ..49 run data modify storage test: scan.aoe.width set value 0.5d

function test:scan/aoe/check with storage test: scan.aoe

particle end_rod ~ ~ ~ 0 0 0 0 0

execute if score @s test.repeat matches 0.. positioned ^ ^ ^1 run function test:scan/aoe/
execute if score @s test.repeat matches ..0 positioned as @s run function test:attack/damage
