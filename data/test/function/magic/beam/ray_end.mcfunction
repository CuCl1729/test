#> test:magic/beam/ray_end
# 実行位置 = 線の終わり(壁の一歩手前、または射程の終わり)。
# 範囲と組んでいる(endpoint_aoe が 1)ときだけ、ここを中心に円状の効果を出す。
# 貫いた敵(beam_hit)は magic/aoe/probe が外すので、直撃と二重には当たらない
execute if data storage test: magic.player.beam_link run function test:magic/beam/link/capture

execute unless data storage test: magic.player{endpoint_aoe:1} run return 0
execute unless data storage test: magic.player.aoe.radius run return 0

# 場と同じく、範囲は4 tickごとに描き続け、当てる回の爆発・点の演出は出さない
scoreboard players operation #beam_draw test.temporary = #clock test.time
scoreboard players operation #beam_draw test.temporary %= #4 test.constant
execute if score #beam_draw test.temporary matches 0 run function test:magic/field/draw

execute if score #beam_apply test.temporary matches 0 run return 0
execute store result score #aoe_radius test.temporary run data get storage test: magic.player.aoe.radius
scoreboard players set #aoe_quiet test.temporary 1
function test:magic/aoe/scan
function test:magic/aoe/apply
scoreboard players set #aoe_quiet test.temporary 0
