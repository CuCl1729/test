#> test:craft/equip_magic/copy_name
# @macro index/slot: 枠の番号とスロット。スロットに置いたアイテムの名前を、説明文用に枠の name へ写す。
# 名前はいつもリスト形式で持たせる(魔法の名前は [""、部品…] のリスト。文字や1つの部品ならリストに包む)

$data modify storage test: loot.item.components."minecraft:custom_data".equip.procs[$(index)].name set value [""]
$execute if data block ~ ~ ~ Items[{Slot:$(slot)b}].components."minecraft:custom_name"[0] run data modify storage test: loot.item.components."minecraft:custom_data".equip.procs[$(index)].name set from block ~ ~ ~ Items[{Slot:$(slot)b}].components."minecraft:custom_name"
$execute unless data block ~ ~ ~ Items[{Slot:$(slot)b}].components."minecraft:custom_name"[0] if data block ~ ~ ~ Items[{Slot:$(slot)b}].components."minecraft:custom_name" run data modify storage test: loot.item.components."minecraft:custom_data".equip.procs[$(index)].name append from block ~ ~ ~ Items[{Slot:$(slot)b}].components."minecraft:custom_name"
