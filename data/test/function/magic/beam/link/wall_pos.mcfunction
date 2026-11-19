#> test:magic/beam/link/wall_pos
# @s = wall_end がちょうど出した捨てマーカー(align xyz で壁のブロック座標に揃えてある)。
# その Pos を link_work.wall に書き取り、自分自身だけを消す
data modify storage test: link_work.wall set value {}
data modify storage test: link_work.wall.x set from entity @s Pos[0]
data modify storage test: link_work.wall.y set from entity @s Pos[1]
data modify storage test: link_work.wall.z set from entity @s Pos[2]

kill @s
