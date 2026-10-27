#> test:craft/equip_magic/apply_slot
# @s = 付与台マーカー。@macro index: 自動発動の枠の番号(0から) / slot: その枠に入れるものを置くスロット。
# 装備(storage test: loot.item)にその番号の枠があり、スロットに入れられるものがあれば、置いたものの種類ごとに入れる。
# 枠に入るのは1種類だけなので、前の中身は上書きする(test:craft/equip_magic/slot_reset)

$execute unless data storage test: loot.item.components."minecraft:custom_data".equip.procs[$(index)] run return 0

$execute if data block ~ ~ ~ Items[{Slot:$(slot)b}].components."minecraft:custom_data".test{magic:1b} run return run function test:craft/equip_magic/apply_magic {index:$(index),slot:$(slot)}
