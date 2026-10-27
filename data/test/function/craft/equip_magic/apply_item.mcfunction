#> test:craft/equip_magic/apply_item
# @s = 付与台マーカー。@macro index/slot: 枠の番号とスロット。スロットの消耗品のidを読んで apply_item_def へ渡す

$data modify storage test: equip_magic_work.item_arg set value {index:$(index),slot:$(slot)}
$data modify storage test: equip_magic_work.item_arg.id set from block ~ ~ ~ Items[{Slot:$(slot)b}].components."minecraft:custom_data".test.consumable
function test:craft/equip_magic/apply_item_def with storage test: equip_magic_work.item_arg
