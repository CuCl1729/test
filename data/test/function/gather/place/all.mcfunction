#> test:gather/place/all
# 一覧(asset.gather_point)から消えた・変わったポイントのエンティティを片付け、一覧にあるのに無いものを、
# test:action と test:turn の同じ座標に置く(読み込まれているチャンクだけ)。手で置く作業が無いので、2つのマップはずれない

scoreboard players set #gather_clock test.time 0
execute as @e[type=interaction,tag=gather_point] run function test:gather/place/check with entity @s data.gather
data modify storage test: gather_work.queue set from storage test: asset.gather_point_ids
function test:gather/place/loop
