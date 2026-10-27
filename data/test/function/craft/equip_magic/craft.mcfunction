#> test:craft/equip_magic/craft
# @s = 付与台マーカー。スロット9の装備(防具・アクセサリー)の自動発動の枠に、スロット10・11・12に置いたもの
# (魔法・ルーン・消耗品)を1・2・3個目の枠の順に入れる。何も置かなかった枠は今のまま。
# 入れた魔法・ルーンは使い切り。消耗品は「どれを使うか」の設定だけなので消費しない。
# 枠の無い位置に置いたものは消費せずに残す。
# 上書きした枠にルーンが入っていたら、そのルーンを返す

execute unless data block ~ ~ ~ Items[{Slot:9b}] unless data block ~ ~ ~ Items[{Slot:10b}] unless data block ~ ~ ~ Items[{Slot:11b}] unless data block ~ ~ ~ Items[{Slot:12b}] run return 0

execute unless data block ~ ~ ~ Items[{Slot:9b}].components."minecraft:custom_data".equip.procs[0] run return run tellraw @a[distance=..6] {text:"スロット9に、自動発動の枠がある装備を置いてください",color:"red"}

data remove storage test: loot.item
data modify storage test: loot.item.id set from block ~ ~ ~ Items[{Slot:9b}].id
data modify storage test: loot.item.components set from block ~ ~ ~ Items[{Slot:9b}].components

data modify storage test: equip_magic_work.returns set value []
scoreboard players set #imbued test.temporary 0
function test:craft/equip_magic/apply_slot {index:0,slot:10}
function test:craft/equip_magic/apply_slot {index:1,slot:11}
function test:craft/equip_magic/apply_slot {index:2,slot:12}

execute if score #imbued test.temporary matches 0 run return run tellraw @a[distance=..6] {text:"スロット10〜12に、枠に入れる魔法・ルーン・消耗品を置いてください(10が1つ目の枠)",color:"red"}

function test:item/weapon/lore/render
function test:loot/give

data remove block ~ ~ ~ Items[{Slot:9b}]

# 上書きした枠のルーンを返す(装備を渡し終えてから。loot.itemを使い回すため)
function test:craft/equip_magic/return_loop

tellraw @a[distance=..6] {text:"装備の枠に入れました",color:"light_purple"}
