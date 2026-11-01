#> test:npc/cart/give_slot
# @s = トロッコ(実行位置も @s)。@macro slot: スロット。そこにあるもの(プレイヤーが置いたもの)を、tag=npc_cart_clicker の人の足元に落として消す

$execute unless data entity @s Items[{Slot:$(slot)b}] run return 0
$data modify storage test: loot.item set from entity @s Items[{Slot:$(slot)b}]
data remove storage test: loot.item.Slot
$data remove entity @s Items[{Slot:$(slot)b}]
execute at @a[tag=npc_cart_clicker,limit=1] run function test:item/drop_at
