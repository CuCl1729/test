#> test:craft/custom/main
# @s = カスタムクラフターのマーカー(test:station/tick から毎tick。実行位置は樽)。
# 材料の枠 3〜5・12〜14・21〜23、結果の枠 16。結果の枠には本物を置き、取られたら材料を減らす(取り方は問わない)。
# 記録(マーカーの data.crafter): grid = 前に判定した材料の枠の写し、show = 結果の枠に置いたもの、real = 本物か、recipe
#   1. 結果の枠が show と違えば、取られた(本物)・取られた(バリア)・何か置かれた、を処理する
#   2. 材料の枠が grid と違えば(または 1 で何かあれば)、判定し直して結果の枠を置き直す

data modify storage test: craft_work.now set value {}
data modify storage test: craft_work.now set from block ~ ~ ~ Items[{Slot:16b}]
data remove storage test: craft_work.now.Slot
scoreboard players set #cc_reeval test.temporary 0
execute if data entity @s data.crafter.show run function test:craft/custom/check_show
execute unless data entity @s data.crafter.show if data storage test: craft_work.now.id run function test:craft/custom/return_slot

function test:craft/custom/grid_snapshot
scoreboard players set #cc_changed test.temporary 1
data modify storage test: craft_work.cmp set from storage test: craft_work.grid
execute if data entity @s data.crafter.grid store success score #cc_changed test.temporary run data modify storage test: craft_work.cmp set from entity @s data.crafter.grid
execute if score #cc_changed test.temporary matches 1 run scoreboard players set #cc_reeval test.temporary 1
execute if score #cc_reeval test.temporary matches 1 run function test:craft/custom/eval_place
