#> test:battle/ui/item_minecart_populate_slot
# @macro id/count: 消耗品のid・持っている数。消耗品と同じ見た目のアイコンをスロット #item_line に入れる。
# 取っても本物の消耗品にならないよう、custom_data は印(battle_item_pick)だけにする(test:battle/ui/clear_items が消す)

$function test:item/consumable/build {id:"$(id)"}
data modify storage test: loot.item.components."minecraft:custom_data" set value {test:{battle_item_pick:1b}}

# 1スロットに入る数(64)までにする
scoreboard players set #item_count test.temporary 0
$scoreboard players set #item_count test.temporary $(count)
execute if score #item_count test.temporary matches 65.. run scoreboard players set #item_count test.temporary 64
execute store result storage test: loot.item.count int 1 run scoreboard players get #item_count test.temporary
execute store result storage test: loot.item.Slot byte 1 run scoreboard players get #item_line test.temporary

data modify entity @n[tag=item_minecart] Items append from storage test: loot.item
