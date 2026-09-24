#> test:battle/ui/skill_category_minecart_populate
# @s = カテゴリ選択中のプレイヤー(トロッコ式)。魔法/アクティブスキルの2択を出す
# (test:battle/ui/skill_hover_summonが魔法・アクティブスキル両方使える場合にだけ呼ぶ)

tag @n[tag=skill_minecart,tag=!target_minecart,tag=!skill_effect_minecart] add skill_category_minecart

data modify entity @n[tag=skill_category_minecart] Items set value [{Slot:0b,id:"ender_pearl",count:1,components:{"minecraft:custom_name":{text:"魔法",italic:false,color:"aqua"},"minecraft:custom_data":{test:{skill_category:"magic"}}}},{Slot:1b,id:"nether_star",count:1,components:{"minecraft:custom_name":{text:"アクティブスキル",italic:false,color:"gold"},"minecraft:custom_data":{test:{skill_category:"active"}}}}]
