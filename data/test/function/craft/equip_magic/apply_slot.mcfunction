#> test:craft/equip_magic/apply_slot
# @s = 魔法付与台マーカー。@macro index: 自動発動の枠の番号(0から) / slot: その枠に入れる魔法を置くスロット。
# スロットに魔法があり、装備(storage test: loot.item)にその番号の枠があるときだけ入れて、魔法をスロットから消す

$execute unless data block ~ ~ ~ Items[{Slot:$(slot)b}].components."minecraft:custom_data".test{magic:1b} run return 0
$execute unless data storage test: loot.item.components."minecraft:custom_data".equip.procs[$(index)] run return 0

$data modify storage test: loot.item.components."minecraft:custom_data".equip.procs[$(index)].magic set from block ~ ~ ~ Items[{Slot:$(slot)b}].components."minecraft:custom_data".test

# 名前は説明文用に、いつもリスト形式で持たせる(魔法の名前は [""、部品…] のリスト)
$data modify storage test: loot.item.components."minecraft:custom_data".equip.procs[$(index)].name set value [""]
$execute if data block ~ ~ ~ Items[{Slot:$(slot)b}].components."minecraft:custom_name"[0] run data modify storage test: loot.item.components."minecraft:custom_data".equip.procs[$(index)].name set from block ~ ~ ~ Items[{Slot:$(slot)b}].components."minecraft:custom_name"
$execute unless data block ~ ~ ~ Items[{Slot:$(slot)b}].components."minecraft:custom_name"[0] if data block ~ ~ ~ Items[{Slot:$(slot)b}].components."minecraft:custom_name" run data modify storage test: loot.item.components."minecraft:custom_data".equip.procs[$(index)].name append from block ~ ~ ~ Items[{Slot:$(slot)b}].components."minecraft:custom_name"

$data remove block ~ ~ ~ Items[{Slot:$(slot)b}]
scoreboard players add #imbued test.temporary 1
