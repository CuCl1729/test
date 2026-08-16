#> test:battle/ui/skill_minecart
# @s = 現在手番のプレイヤー(アイテム式)。足元に隠れているトロッコ(なければ念のため召喚)を
# 選択確定状態にし、目線の位置へ移動させる

scoreboard players set @e[tag=battle_marker,sort=nearest,limit=1] test.battle.awaiting_skill 2

execute unless entity @e[tag=skill_minecart,distance=..3] run function test:battle/ui/skill_hover_summon

execute anchored eyes positioned ^ ^-0.35 ^ run tp @e[tag=skill_minecart,sort=nearest,limit=1] ~ ~ ~

tellraw @s [{text:"トロッコを開いて、使う魔法のタイプを選んでください",color:light_purple}]
