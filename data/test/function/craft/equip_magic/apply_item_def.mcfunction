#> test:craft/equip_magic/apply_item_def
# @s = 付与台マーカー。@macro index/slot/id: 枠の番号・スロット・消耗品のid。
# 枠を kind:"item" にして「どの消耗品を使うか」だけを設定する。枠にアイテムそのものは入れないので、
# 置いた消耗品は消費せずにスロットに残す(使うときはプレイヤーの持ち物から1個減らす)

$execute unless data storage test: asset.consumable.$(id) run return run tellraw @a[distance=..6] {text:"この消耗品は定義が見つからないため設定できません",color:"red"}

$function test:craft/equip_magic/slot_reset {index:$(index),kind:"item"}
$data modify storage test: loot.item.components."minecraft:custom_data".equip.procs[$(index)].item set value "$(id)"
$function test:craft/equip_magic/copy_name {index:$(index),slot:$(slot)}

scoreboard players add #imbued test.temporary 1
