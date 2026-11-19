#> test:magic/field/draw
# 実行位置 = 範囲の中心。magic.player.aoe.radius の円盤をすぐ消える粒で描く
# (test:magic/field/tick と、ビームの行き止まり test:magic/beam/ray_end から4 tickごと)。
# 円の点の並べ方は当たり判定と同じ test:magic/aoe/scan_rings に任せる
data modify storage test: circle.Command set value "particle minecraft:dust{color:[0.75,0.55,1.0],scale:1.0} ~ ~0.1 ~ 0 0 0 0 1"
data modify storage test: circle.Yaw set value 0.0f
data modify storage test: circle.Pitch set value 0.0f
particle minecraft:dust{color:[0.75,0.55,1.0],scale:1.0} ~ ~0.1 ~ 0 0 0 0 1
execute store result score #aoe_ring test.temporary run data get storage test: magic.player.aoe.radius
execute summon marker run function test:magic/aoe/scan_rings
