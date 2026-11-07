# @s = カスタムクラフター。材料の変化で作成ボタンを更新し、取られたら本人の持ち物へ渡す。
data modify storage test: craft_work.now set value {}
data modify storage test: craft_work.now set from block ~ ~ ~ Items[{Slot:16b}]
data remove storage test: craft_work.now.Slot
execute if data entity @s data.crafter{real:1b} run function test:craft/custom/migrate_result
scoreboard players set #cc_reeval test.temporary 0
execute if data entity @s data.crafter.show run function test:craft/custom/check_show
execute unless data entity @s data.crafter.show if data storage test: craft_work.now.id run function test:craft/custom/return_slot

function test:craft/custom/grid_snapshot
scoreboard players set #cc_changed test.temporary 1
data modify storage test: craft_work.cmp set from storage test: craft_work.grid
execute if data entity @s data.crafter.grid store success score #cc_changed test.temporary run data modify storage test: craft_work.cmp set from entity @s data.crafter.grid
execute if score #cc_changed test.temporary matches 1 run scoreboard players set #cc_reeval test.temporary 1
execute if score #cc_reeval test.temporary matches 1 run function test:craft/custom/eval_place
