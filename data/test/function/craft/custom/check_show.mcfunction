# 出力枠が違えば、その場で台の材料を再評価する。元のボタンを持つ人だけが作成できる。
data modify storage test: craft_work.cmp set from entity @s data.crafter.show
execute store success score #cc_diff test.temporary run data modify storage test: craft_work.cmp set from storage test: craft_work.now
execute if score #cc_diff test.temporary matches 0 run return 0
scoreboard players set #cc_reeval test.temporary 1
data modify storage test: station_action.args set value {}
data modify storage test: station_action.args.recipe set from entity @s data.crafter.recipe
function test:station/action/accept {slot:16,call:"craft/custom/make"}
execute if data storage test: craft_work.now.id run function test:craft/custom/return_slot
data remove entity @s data.crafter.show
