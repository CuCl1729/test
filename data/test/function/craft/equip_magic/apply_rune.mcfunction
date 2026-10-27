#> test:craft/equip_magic/apply_rune
# @s = 付与台マーカー。@macro index/slot: 枠の番号とスロット。スロットのルーンのidを読んで apply_rune_def へ渡す

$data modify storage test: equip_magic_work.rune_arg set value {index:$(index),slot:$(slot)}
$data modify storage test: equip_magic_work.rune_arg.id set from block ~ ~ ~ Items[{Slot:$(slot)b}].components."minecraft:custom_data".test.rune
function test:craft/equip_magic/apply_rune_def with storage test: equip_magic_work.rune_arg
