#> test:npc/cart/shop/display
# @s = 店のトロッコ。@macro kind/id/count/buy/sell/slot/i/pid/npc: 品物1つ。本物と同じ見た目・名前の見本を作り、説明文に値段を足して置く。
# custom_data は UI の印(test.shop_ui)だけにする(本物の印が無いので、見本が本物として数えられることはない)。買えないものは act:"none"

$function test:craft/custom/out/$(kind) {id:"$(id)"}
$data modify storage test: loot.item.count set value $(count)
$data modify storage test: loot.item.components."minecraft:custom_data" set value {test:{shop_ui:{cart:$(pid),npc:"$(npc)",act:"buy",i:$(i)}}}
$scoreboard players set #sb test.temporary $(buy)
$scoreboard players set #ss test.temporary $(sell)
$execute if score #sb test.temporary matches 0.. run data modify storage test: loot.item.components."minecraft:lore" append value {text:"買値 $(buy)G / 1回で $(count)個",color:"yellow",italic:false}
$execute if score #ss test.temporary matches 0.. run data modify storage test: loot.item.components."minecraft:lore" append value {text:"売値 $(sell)G / $(count)個ごと",color:"green",italic:false}
execute if score #sb test.temporary matches ..-1 run data modify storage test: loot.item.components."minecraft:custom_data".test.shop_ui.act set value "none"
$data modify storage test: loot.item.Slot set value $(slot)b
data modify entity @s Items append from storage test: loot.item
data remove storage test: loot.item.Slot
