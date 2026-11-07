#> test:battle/ui/cart_pick
# @s = 空いた枠のトロッコ。元のボタンを戻してから、その表示のボタンを取った人を調べる。
$data modify storage test: battle_ui.click set value {slot:$(slot),action:"$(action)"}
$data modify storage test: battle_ui.click.epoch set from entity @n[tag=battle_marker,distance=..64] data.turn.menus.$(screen)[{Slot:$(slot)b}].components."minecraft:custom_data".test.battle_input.epoch
execute unless data storage test: battle_ui.click.epoch run return 0
execute store result score #battle_ui_expected test.temporary run data get storage test: battle_ui.click.epoch
execute unless score @s test.time = #battle_ui_expected test.temporary run return 0
$data modify entity @s Items append from entity @n[tag=battle_marker,distance=..64] data.turn.menus.$(screen)[{Slot:$(slot)b}]
function test:battle/ui/cart_holder with storage test: battle_ui.click
