#> test:battle/ui/cart_bind
# @s = 表示が完成したトロッコ。表示ごとに印を変え、持ち越したアイコンを無効にする。
execute store result score @s test.time run scoreboard players add #battle_ui_epoch test.time 1
execute store result storage test: battle_ui.stamp.epoch int 1 run scoreboard players get @s test.time
data modify storage test: battle_ui.slots set from entity @s Items
function test:battle/ui/cart_stamp_loop
$data modify entity @n[tag=battle_marker,distance=..64] data.turn.menus.$(screen) set from entity @s Items
