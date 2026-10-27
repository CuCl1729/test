#> test:craft/equip_magic/slot_reset
# @macro index: 枠の番号 / kind: これから入れるものの種類("magic" / "rune" / "item")。
# 枠を {event, kind} だけに作り直す(前の中身の magic・item・rune・status を残さないため)。
# eventは作るときに抽選した値なので、入れ替えても残す

$data modify storage test: equip_magic_work.event set from storage test: loot.item.components."minecraft:custom_data".equip.procs[$(index)].event
$data modify storage test: loot.item.components."minecraft:custom_data".equip.procs[$(index)] set value {kind:"$(kind)"}
$data modify storage test: loot.item.components."minecraft:custom_data".equip.procs[$(index)].event set from storage test: equip_magic_work.event
