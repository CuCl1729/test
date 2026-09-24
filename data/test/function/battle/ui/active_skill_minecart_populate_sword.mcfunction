#> test:battle/ui/active_skill_minecart_populate_sword
# @s = アクティブスキル選択中のプレイヤー(トロッコ式)。剣スキル(範囲攻撃)をスロット0へ置く

data modify entity @n[tag=active_skill_minecart] Items append value {Slot:0b,id:"iron_sword",count:1,components:{"minecraft:custom_name":{text:"剣技: 範囲攻撃",italic:false,color:"aqua"},"minecraft:custom_data":{test:{active_skill:1b}}}}
data modify storage test: battle.temporary.active_skill_slot append value {kind:"sword"}
scoreboard players add #active_slot test.temporary 1
