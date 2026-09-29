#> test:scan/aoe/ring
# 半径#aoe_ringの弧を1本処理し、半径を1増やして#aoe_reachまで再帰する。
# 角度の刻みは573÷半径(0.1°単位。573は1ラジアン≒57.3°の10倍)なので、弧の上の点の間隔は1ブロック以下になる

scoreboard players set #aoe_step test.temporary 573
scoreboard players operation #aoe_step test.temporary /= #aoe_ring test.temporary

scoreboard players set #aoe_theta test.temporary 0
scoreboard players operation #aoe_theta test.temporary -= #aoe_half_tenths test.temporary
function test:scan/aoe/arc

scoreboard players add #aoe_ring test.temporary 1
execute if score #aoe_ring test.temporary <= #aoe_reach test.temporary run function test:scan/aoe/ring
