#> test:battle/ui/item_hover_hide
# @s = メインハンドが「アイテム」でなくなったプレイヤー。アイテムのトロッコを消す(無ければ何もしない)

execute as @e[tag=item_minecart,distance=..8] run data remove entity @s Items
kill @e[tag=item_minecart,distance=..8]
