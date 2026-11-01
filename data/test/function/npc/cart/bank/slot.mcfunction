#> test:npc/cart/bank/slot
# @s = 銀行のトロッコ(実行位置も @s)。@macro slot: 預ける枠。コインなら値×枚数を #bd に足して消し、コイン以外は持ち主(tag=npc_cart_owner)に返す

$execute unless data entity @s Items[{Slot:$(slot)b}] run return 0
$data modify storage test: cart_work.it set from entity @s Items[{Slot:$(slot)b}]
$data remove entity @s Items[{Slot:$(slot)b}]
execute if data storage test: cart_work.it.components."minecraft:custom_data".test.coin run return run function test:npc/cart/bank/coin
data modify storage test: loot.item set from storage test: cart_work.it
data remove storage test: loot.item.Slot
execute at @a[tag=npc_cart_owner,limit=1] run function test:item/drop_at
