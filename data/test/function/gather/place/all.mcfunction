#> test:gather/place/all
# ワールドの記録(storage test: gather_world)から消えた・変わったポイントのエンティティを片付け、記録にあるのに無いものを、
# test:action と test:turn の同じ座標に置く(読み込まれているチャンクだけ)。2つのマップは同じ記録から置くので、ずれない
scoreboard players set #gather_clock test.time 0
execute as @e[type=interaction,tag=gather_point] run function test:gather/place/check with entity @s data.gather
data modify storage test: gather_work.queue set from storage test: gather_world.ids
function test:gather/place/loop
