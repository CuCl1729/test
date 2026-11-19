#> test:magic/beam/fan_loop
# 本数ぶん、視線からの左右のずれを求めて1本ずつ引く。
# ずれ = 扇の幅 × (2 × 番号 − 本数 + 1) ÷ (2 × (本数 + 1))。投射の扇と同じ刻み(幅 ÷ 本数+1)で、
# 本数が1なら 0(真ん中だけ)、偶数でも左右対称になる
scoreboard players operation #beam_off test.temporary = #beam_index test.temporary
scoreboard players operation #beam_off test.temporary *= #2 test.constant
scoreboard players operation #beam_off test.temporary -= #beam_count test.temporary
scoreboard players add #beam_off test.temporary 1
scoreboard players operation #beam_off test.temporary *= #beam_fan test.temporary

scoreboard players operation #beam_div test.temporary = #beam_count test.temporary
scoreboard players add #beam_div test.temporary 1
scoreboard players operation #beam_div test.temporary *= #2 test.constant
scoreboard players operation #beam_off test.temporary /= #beam_div test.temporary

execute store result storage test: beam_work.yaw float 0.01 run scoreboard players get #beam_off test.temporary
function test:magic/beam/fan_one with storage test: beam_work

scoreboard players add #beam_index test.temporary 1
execute if score #beam_index test.temporary < #beam_count test.temporary run function test:magic/beam/fan_loop
