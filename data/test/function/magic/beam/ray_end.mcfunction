#> test:magic/beam/ray_end
# 実行位置 = 線の終わり(壁の一歩手前、または射程の終わり)。
# 範囲と組んでいる(endpoint_aoe が 1)ときだけ、ここを中心に円状の効果を出す。
# 貫いた敵(beam_hit)は magic/aoe/probe が外すので、直撃と二重には当たらない
execute if data storage test: magic.player.beam_link run function test:magic/beam/link/capture

execute if score #beam_apply test.temporary matches 0 run return 0
execute unless data storage test: magic.player{endpoint_aoe:1} run return 0
execute unless data storage test: magic.player.aoe.radius run return 0

execute store result score #aoe_radius test.temporary run data get storage test: magic.player.aoe.radius
function test:magic/aoe/scan
function test:magic/aoe/apply
