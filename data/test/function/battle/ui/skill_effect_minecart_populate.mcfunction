#> test:battle/ui/skill_effect_minecart_populate
# @s = 効果選択中のプレイヤー(トロッコ式)。現在の選択状態を全スロットへ反映し直す
# (クラフター方式: アイコンは取っても消費されず、選択のON/OFFが名前に反映されてカートへ戻る)

data remove entity @n[tag=skill_effect_minecart] Items[{Slot:0b}]
data remove entity @n[tag=skill_effect_minecart] Items[{Slot:1b}]
data remove entity @n[tag=skill_effect_minecart] Items[{Slot:2b}]
data remove entity @n[tag=skill_effect_minecart] Items[{Slot:8b}]

execute if score @s test.battle.skill_type matches 1 if score @s test.magic.known.heal matches 1 if score @s test.magic.select.heal matches 1 run data modify entity @n[tag=skill_effect_minecart] Items append value {Slot:0b,id:"ghast_tear",count:1,components:{"minecraft:custom_name":{text:"[有効] 回復",italic:false,color:"green"},"minecraft:custom_data":{test:{skill_effect:"heal"}}}}
execute if score @s test.battle.skill_type matches 1 if score @s test.magic.known.heal matches 1 unless score @s test.magic.select.heal matches 1 run data modify entity @n[tag=skill_effect_minecart] Items append value {Slot:0b,id:"ghast_tear",count:1,components:{"minecraft:custom_name":{text:"[無効] 回復",italic:false},"minecraft:custom_data":{test:{skill_effect:"heal"}}}}

execute if score @s test.battle.skill_type matches 2 if score @s test.magic.known.fire matches 1 if score @s test.magic.select.fire matches 1 run data modify entity @n[tag=skill_effect_minecart] Items append value {Slot:0b,id:"fire_charge",count:1,components:{"minecraft:custom_name":{text:"[有効] 火炎",italic:false,color:"green"},"minecraft:custom_data":{test:{skill_effect:"fire"}}}}
execute if score @s test.battle.skill_type matches 2 if score @s test.magic.known.fire matches 1 unless score @s test.magic.select.fire matches 1 run data modify entity @n[tag=skill_effect_minecart] Items append value {Slot:0b,id:"fire_charge",count:1,components:{"minecraft:custom_name":{text:"[無効] 火炎",italic:false},"minecraft:custom_data":{test:{skill_effect:"fire"}}}}

execute if score @s test.battle.skill_type matches 2 if score @s test.magic.known.atk matches 1 if score @s test.magic.select.atk matches 1 run data modify entity @n[tag=skill_effect_minecart] Items append value {Slot:1b,id:"redstone",count:1,components:{"minecraft:custom_name":{text:"[有効] 威力上昇",italic:false,color:"green"},"minecraft:custom_data":{test:{skill_effect:"atk"}}}}
execute if score @s test.battle.skill_type matches 2 if score @s test.magic.known.atk matches 1 unless score @s test.magic.select.atk matches 1 run data modify entity @n[tag=skill_effect_minecart] Items append value {Slot:1b,id:"redstone",count:1,components:{"minecraft:custom_name":{text:"[無効] 威力上昇",italic:false},"minecraft:custom_data":{test:{skill_effect:"atk"}}}}

execute if score @s test.battle.skill_type matches 2 if score @s test.magic.known.gravity matches 1 if score @s test.magic.select.gravity matches 1 run data modify entity @n[tag=skill_effect_minecart] Items append value {Slot:2b,id:"feather",count:1,components:{"minecraft:custom_name":{text:"[有効] 重力",italic:false,color:"green"},"minecraft:custom_data":{test:{skill_effect:"gravity"}}}}
execute if score @s test.battle.skill_type matches 2 if score @s test.magic.known.gravity matches 1 unless score @s test.magic.select.gravity matches 1 run data modify entity @n[tag=skill_effect_minecart] Items append value {Slot:2b,id:"feather",count:1,components:{"minecraft:custom_name":{text:"[無効] 重力",italic:false},"minecraft:custom_data":{test:{skill_effect:"gravity"}}}}

data modify entity @n[tag=skill_effect_minecart] Items append value {Slot:8b,id:"ender_eye",count:1,components:{"minecraft:custom_name":{text:"詠唱する",italic:false},"minecraft:custom_data":{test:{skill_effect:"cast"}}}}
