#> test:magic/beam/fan
# @s = 詠唱者(at @s)。目の高さから視線方向へ、本数ぶんの線を左右対称の扇状に引く。
# 向きを覚えないので、扇はそのまま視線を追う。扇の幅はスプレッドシートの「定数」タブ
scoreboard players operation #beam_count test.temporary = @s test.multi_shot
execute if score #beam_count test.temporary matches ..0 run scoreboard players set #beam_count test.temporary 1

execute store result score #beam_fan test.temporary run data get storage test: asset.config.magic_fan_angle 100
scoreboard players set #beam_index test.temporary 0
function test:magic/beam/fan_loop
