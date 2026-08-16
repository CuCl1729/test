#> test:battle/ui/skill_minecart_resolve
# @s = タイプアイコンを取ったプレイヤー。$(type) = 選ばれた魔法タイプ(1=自己/2=投射)

# トロッコ経由の確定はtest:battle/ui/item_selectを通らないため、他の行動アイテムをここで片付ける
# (skillアイテム自体はまだ手元に残す。効果選択カートが終わるまでhover_tickの追従に使うため、
#  実際に唱える直前のtest:battle/ui/skill_effect_minecart_resolveで片付ける)
clear @s minecraft:iron_sword[custom_data~{test:{battle_action:"attack"}}]
clear @s minecraft:potion[custom_data~{test:{battle_action:"item"}}]
clear @s minecraft:shield[custom_data~{test:{battle_action:"defend"}}]

# トロッコから拾った選択用アイコン自体も手元から消す
clear @s minecraft:glass_bottle[custom_data~{test:{skill_choice:"self"}}]
clear @s minecraft:snowball[custom_data~{test:{skill_choice:"projectile"}}]

$scoreboard players set @s test.battle.skill_type $(type)

# タイプが決まったので、続けて今回の詠唱で使う効果の組み合わせを選ばせる。
# トロッコを召喚し直さず、同じ実体を効果選択用として使い回す
tag @e[tag=skill_minecart,distance=..3] add skill_effect_minecart
scoreboard players set @e[tag=battle_marker,sort=nearest,limit=1] test.battle.awaiting_skill 4

scoreboard players set @s test.magic.select.fire 0
scoreboard players set @s test.magic.select.atk 0
scoreboard players set @s test.magic.select.heal 0
scoreboard players set @s test.magic.select.gravity 0

function test:battle/ui/skill_effect_minecart_populate

tellraw @s [{text:"トロッコを開いて、使う効果を選び(複数可)最後に「詠唱する」を取ってください",color:light_purple}]
