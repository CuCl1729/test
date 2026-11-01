#> test:craft/custom/check_show
# @s = マーカー。結果の枠(craft_work.now。空なら {})が、前に置いたもの(data.crafter.show)と同じか確かめる。
# 違えば: 本物なら取られた(test:craft/custom/taken)。バリアなら、置かれた物があれば返す。どちらも判定し直す

data modify storage test: craft_work.cmp set from entity @s data.crafter.show
execute store success score #cc_diff test.temporary run data modify storage test: craft_work.cmp set from storage test: craft_work.now
execute if score #cc_diff test.temporary matches 0 run return 0
scoreboard players set #cc_reeval test.temporary 1
execute if data entity @s data.crafter{real:1b} run return run function test:craft/custom/taken
execute if data storage test: craft_work.now.id run function test:craft/custom/return_slot
data remove entity @s data.crafter.show
