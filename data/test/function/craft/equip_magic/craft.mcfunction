#> test:craft/equip_magic/craft
# @s = 魔法付与台マーカー。スロット9の装備(防具・アクセサリー)の自動発動の枠に、スロット10・11・12の魔法(nether_star)を
# 1・2・3個目の枠の順に入れる。魔法を置かなかった枠は今の魔法のまま。
# 入れた魔法は使い切り。枠の無い位置に置いた魔法は消費せずに残す

execute unless data block ~ ~ ~ Items[{Slot:9b}] unless data block ~ ~ ~ Items[{Slot:10b}] unless data block ~ ~ ~ Items[{Slot:11b}] unless data block ~ ~ ~ Items[{Slot:12b}] run return 0

execute unless data block ~ ~ ~ Items[{Slot:9b}].components."minecraft:custom_data".equip.procs[0] run return run tellraw @a[distance=..6] {text:"スロット9に、自動発動の枠がある装備を置いてください",color:"red"}

data remove storage test: loot.item
data modify storage test: loot.item.id set from block ~ ~ ~ Items[{Slot:9b}].id
data modify storage test: loot.item.components set from block ~ ~ ~ Items[{Slot:9b}].components

scoreboard players set #imbued test.temporary 0
function test:craft/equip_magic/apply_slot {index:0,slot:10}
function test:craft/equip_magic/apply_slot {index:1,slot:11}
function test:craft/equip_magic/apply_slot {index:2,slot:12}

execute if score #imbued test.temporary matches 0 run return run tellraw @a[distance=..6] {text:"スロット10〜12に、枠に入れる魔法を置いてください(10が1つ目の枠)",color:"red"}

function test:item/weapon/lore/render
function test:loot/give

data remove block ~ ~ ~ Items[{Slot:9b}]

tellraw @a[distance=..6] {text:"装備に魔法を付けました",color:"light_purple"}
