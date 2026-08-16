#> test:battle/action/skill
# @s = 行動を選んだ詠唱者。研究ステーションで習得済みの魔法タイプ(自己/投射)を使って魔法を唱える

execute unless score @s test.magic.known.self matches 1 unless score @s test.magic.known.projectile matches 1 run tellraw @s [{text:"使える魔法がありません",color:gray}]
execute unless score @s test.magic.known.self matches 1 unless score @s test.magic.known.projectile matches 1 run function test:battle/turn_end

execute if score @s test.magic.known.self matches 1 if score @s test.magic.known.projectile matches 1 if score @s test.settings.battle_ui matches 1 run function test:battle/ui/skill_select
execute if score @s test.magic.known.self matches 1 if score @s test.magic.known.projectile matches 1 if score @s test.settings.battle_ui matches 2 run function test:battle/ui/skill_minecart
execute if score @s test.magic.known.self matches 1 unless score @s test.magic.known.projectile matches 1 run function test:battle/action/skill_cast/self
execute unless score @s test.magic.known.self matches 1 if score @s test.magic.known.projectile matches 1 run function test:battle/action/skill_cast/projectile
