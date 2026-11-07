# 旧版が枠16に置いた本物の見本だけ外す。交換された私物には触れない。
data modify storage test: craft_work.cmp set from entity @s data.crafter.show
execute store success score #cc_diff test.temporary run data modify storage test: craft_work.cmp set from storage test: craft_work.now
execute if score #cc_diff test.temporary matches 0 run data remove block ~ ~ ~ Items[{Slot:16b}]
execute if score #cc_diff test.temporary matches 0 run data modify storage test: craft_work.now set value {}
data remove entity @s data.crafter.real
data remove entity @s data.crafter.show
data remove entity @s data.crafter.grid
