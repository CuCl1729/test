#> test:craft/equip_magic/apply_item_def
# @s = 付与台マーカー。@macro index/slot/id: 枠の番号・スロット・消耗品のid。
# 枠を kind:"item" にして「どの消耗品を使うか」だけを設定する。枠にアイテムそのものは入れないので、
# 置いた消耗品は消費せずにスロットに残す(使うときはプレイヤーの持ち物から1個減らす)。
# 残った消耗品は次の装備にも入るので、同じ消耗品が設定済みの枠には何もしない。
# 魔法が入っていた枠を上書きしたときは、魔法が戻らないことを知らせる

$execute unless data storage test: asset.consumable.$(id) run return run tellraw @a[distance=..6] {text:"この消耗品は定義が見つからないため設定できません",color:"red"}

$data modify storage test: equip_magic_work.old set from storage test: loot.item.components."minecraft:custom_data".equip.procs[$(index)]
$execute if data storage test: equip_magic_work.old{kind:"item",item:"$(id)"} run return 0
execute store result score #slot_no test.temporary run data get storage test: equip_magic_work.item_arg.index
scoreboard players add #slot_no test.temporary 1
execute if data storage test: equip_magic_work.old.magic run tellraw @a[distance=..6] [{score:{name:"#slot_no",objective:"test.temporary"},color:"yellow"},{text:"つ目の枠の魔法を、消耗品で置き換えました(魔法は戻りません)",color:"yellow"}]

$function test:craft/equip_magic/slot_reset {index:$(index),kind:"item"}
$data modify storage test: loot.item.components."minecraft:custom_data".equip.procs[$(index)].item set value "$(id)"
$function test:craft/equip_magic/copy_name {index:$(index),slot:$(slot)}

scoreboard players add #imbued test.temporary 1
