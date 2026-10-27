#> test:craft/equip_magic/apply_magic
# @s = 付与台マーカー。@macro index/slot: 枠の番号とスロット。スロットの魔法を枠に入れ(kind:"magic")、魔法は消費する

$function test:craft/equip_magic/slot_reset {index:$(index),kind:"magic"}

$data modify storage test: loot.item.components."minecraft:custom_data".equip.procs[$(index)].magic set from block ~ ~ ~ Items[{Slot:$(slot)b}].components."minecraft:custom_data".test
$function test:craft/equip_magic/copy_name {index:$(index),slot:$(slot)}

$data remove block ~ ~ ~ Items[{Slot:$(slot)b}]
scoreboard players add #imbued test.temporary 1
