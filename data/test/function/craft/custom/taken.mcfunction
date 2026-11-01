#> test:craft/custom/taken
# @s = マーカー(実行位置は樽)。結果の枠に置いた本物が取られた。材料の枠を判定し直し、同じレシピで作れるなら材料を減らす。
# 作れなければ(結果と同じtickに材料も抜かれた)、渡った結果を取り返す(test:craft/custom/reclaim)

execute if data storage test: craft_work.now.id run function test:craft/custom/return_slot
data modify storage test: craft_work.taken set from entity @s data.crafter
data remove entity @s data.crafter.show
data remove entity @s data.crafter.real

execute as @p[distance=..6] run function #oh_my_dat:please
function test:craft/custom/eval
scoreboard players set #cc_same test.temporary 0
data modify storage test: craft_work.cmp set from storage test: craft_work.taken.recipe
execute if score #cc_ok test.temporary matches 1 store success score #cc_d test.temporary run data modify storage test: craft_work.cmp set from storage test: craft_work.match.recipe
execute if score #cc_ok test.temporary matches 1 if score #cc_d test.temporary matches 0 run scoreboard players set #cc_same test.temporary 1
execute if score #cc_same test.temporary matches 1 run return run function test:craft/custom/consume
function test:craft/custom/reclaim_load with storage test: craft_work.taken
