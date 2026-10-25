#> test:equip/accessory_loop
# @s = プレイヤー。storage test: equip_work.accessories(インベントリのアクセサリー)を先頭から、
# #equip_acc_left個まで集計値に足す

execute unless score #equip_acc_left test.temporary matches 1.. run return 0
execute unless data storage test: equip_work.accessories[0] run return 0

data modify storage test: equip_work.item set from storage test: equip_work.accessories[0].components."minecraft:custom_data"
function test:equip/add_item

data remove storage test: equip_work.accessories[0]
scoreboard players remove #equip_acc_left test.temporary 1
function test:equip/accessory_loop
