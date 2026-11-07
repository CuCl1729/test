#> test:battle/ui/item_pick
# @s = アイテムを選んだプレイヤー。@macro index: data.turn.item_slot の位置。そのアイテムを使う
# (チャット式の test:battle/ui/item_resolve と、トロッコ式の test:battle/ui/item_cart_tick から呼ぶ)

$execute unless data entity @n[tag=battle_marker,distance=..64] data.turn.item_slot[$(index)] run return 0
$data modify storage test: registry_work.item_use set from entity @n[tag=battle_marker,distance=..64] data.turn.item_slot[$(index)]
function test:battle/action/item_use with storage test: registry_work.item_use
