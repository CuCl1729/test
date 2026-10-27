#> test:equip/accessory_loop
# @s = プレイヤー。storage test: equip_work.accessories(インベントリのアクセサリー)を先頭から、
# #equip_acc_left個まで集計値に足す

execute unless score #equip_acc_left test.temporary matches 1.. run return 0
execute unless data storage test: equip_work.accessories[0] run return 0

data modify storage test: equip_work.item set from storage test: equip_work.accessories[0].components."minecraft:custom_data"
# 自動発動の枠を見分けるキーの部位の部分は、何個目のアクセサリーか(acc1, acc2, …)
execute store result storage test: equip_work.acc_arg.n int 1 run scoreboard players get #equip_acc_n test.temporary
function test:equip/accessory_part with storage test: equip_work.acc_arg
function test:equip/add_item

data remove storage test: equip_work.accessories[0]
scoreboard players remove #equip_acc_left test.temporary 1
scoreboard players add #equip_acc_n test.temporary 1
function test:equip/accessory_loop
