#> test:battle/ui/skill_effect_minecart
# @s = 現在手番のプレイヤー(トロッコ式)。test.battle.skill_type(1=自己/2=投射)に応じた
# 効果アイコン+詠唱確定アイコンをトロッコに詰めて選択待ち状態にする
# (クラフター方式: 効果アイコンは取っても消費されず選択をトグルするだけ。詠唱確定アイコンを取った時点で唱える)

scoreboard players set @e[tag=battle_marker,sort=nearest,limit=1] test.battle.awaiting_skill 4

kill @e[tag=skill_minecart,distance=..3]
execute anchored eyes positioned ^ ^-0.35 ^ run summon chest_minecart ~ ~ ~ {Tags:[skill_minecart,skill_effect_minecart],NoGravity:1b,Invulnerable:1b}

scoreboard players set @s test.magic.select.fire 0
scoreboard players set @s test.magic.select.atk 0
scoreboard players set @s test.magic.select.heal 0
scoreboard players set @s test.magic.select.gravity 0

function test:battle/ui/skill_effect_minecart_populate

tellraw @s [{text:"トロッコを開いて、使う効果を選び(複数可)最後に「詠唱する」を取ってください",color:light_purple}]
