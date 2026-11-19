#> test:magic/beam/link/point
# @s = emit がちょうど出した捨てマーカー。summon だけでは実行時の向きを引き継がない(26.3 で確認済み)ので、
# ~ ~ ~ ~ ~ で今の実行の向きを自分の Pos/Rotation に写し取り、その値を link_work.event に写してから
# beam_events へ積み、自分自身だけを消す(他のマーカーには触らない)
teleport @s ~ ~ ~ ~ ~

data modify storage test: link_work.event.x set from entity @s Pos[0]
data modify storage test: link_work.event.y set from entity @s Pos[1]
data modify storage test: link_work.event.z set from entity @s Pos[2]
data modify storage test: link_work.event.yaw set from entity @s Rotation[0]
data modify storage test: link_work.event.pitch set from entity @s Rotation[1]

data modify storage test: beam_events append from storage test: link_work.event

kill @s
