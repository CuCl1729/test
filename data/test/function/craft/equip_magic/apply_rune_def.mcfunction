#> test:craft/equip_magic/apply_rune_def
# @s = 付与台マーカー。@macro index/slot/id: 枠の番号・スロット・ルーンのid。
# 枠を kind:"rune" にして、ルーンのidと、今の定義の能力(status)を写す(後で定義を変えても付与済みの装備は変わらない)。
# ルーンは消費する。定義が見つからないルーンは入れない

$execute unless data storage test: asset.rune.$(id) run return run tellraw @a[distance=..6] {text:"このルーンは定義が見つからないため付けられません",color:"red"}

$function test:craft/equip_magic/slot_reset {index:$(index),kind:"rune"}
$data modify storage test: loot.item.components."minecraft:custom_data".equip.procs[$(index)].rune set value "$(id)"
$data modify storage test: loot.item.components."minecraft:custom_data".equip.procs[$(index)].status set from storage test: asset.rune.$(id).status
$function test:craft/equip_magic/copy_name {index:$(index),slot:$(slot)}

$data remove block ~ ~ ~ Items[{Slot:$(slot)b}]
scoreboard players add #imbued test.temporary 1
