#> test:scan/aoe/arc
# 弧の上の角度#aoe_theta(0.1°単位)に点を1つ置き、#aoe_stepずつ進めて-半角から+半角まで再帰する。
# 点の座標はプレイヤーの向きから見たローカル座標^r·sinθ ^ ^r·cosθ(context_float_provider/scan/aoe_x/aoe_z)。
# 倍率を1000にしているのは、0.001未満の値がマクロ展開で指数表記(1.0E-4など)になり座標として読めなくなるため

# 刻みで割り切れない場合も、最後の点がぴったり右端になるよう揃える
execute if score #aoe_theta test.temporary > #aoe_half_tenths test.temporary run scoreboard players operation #aoe_theta test.temporary = #aoe_half_tenths test.temporary

execute store result storage test: scan.aoe.x double 0.001 run compute default float test:scan/aoe_x 1000
execute store result storage test: scan.aoe.z double 0.001 run compute default float test:scan/aoe_z 1000
function test:scan/aoe/point with storage test: scan.aoe

execute if score #aoe_theta test.temporary >= #aoe_half_tenths test.temporary run return 0

scoreboard players operation #aoe_theta test.temporary += #aoe_step test.temporary
function test:scan/aoe/arc
