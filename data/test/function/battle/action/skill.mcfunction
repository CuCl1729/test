#> test:battle/action/skill
# @s = 行動を選んだ詠唱者(チャット式)。研究ステーションで習得済みの魔法タイプ(自己/投射)を使って魔法を唱える
# (アイテム式はここを経由しない。スキルアイテムを手に持つだけでtest:battle/ui/skill_hover_tickが
#  トロッコを自動表示するため)

execute unless score @s test.magic.known.self matches 1 unless score @s test.magic.known.projectile matches 1 run tellraw @s [{text:"使える魔法がありません",color:gray}]
execute unless score @s test.magic.known.self matches 1 unless score @s test.magic.known.projectile matches 1 run function test:battle/turn_end

execute if score @s test.magic.known.self matches 1 if score @s test.magic.known.projectile matches 1 run function test:battle/ui/skill_select

# 片方のタイプしか習得していない場合はタイプ選択を飛ばし、直接効果選択へ
execute if score @s test.magic.known.self matches 1 unless score @s test.magic.known.projectile matches 1 run scoreboard players set @s test.battle.skill_type 1
execute if score @s test.magic.known.self matches 1 unless score @s test.magic.known.projectile matches 1 run function test:battle/ui/skill_effect_select

execute unless score @s test.magic.known.self matches 1 if score @s test.magic.known.projectile matches 1 run scoreboard players set @s test.battle.skill_type 2
execute unless score @s test.magic.known.self matches 1 if score @s test.magic.known.projectile matches 1 run function test:battle/ui/skill_effect_select
