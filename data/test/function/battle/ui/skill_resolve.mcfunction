#> test:battle/ui/skill_resolve
# @s = 魔法タイプを選択したプレイヤー

scoreboard players operation #skill_select test.battle.skill_select = @s test.battle.skill_select
scoreboard players set @s test.battle.skill_select 0

scoreboard players set @e[tag=battle_marker,sort=nearest,limit=1] test.battle.awaiting_skill 0

execute if score #skill_select test.battle.skill_select matches 1 run function test:battle/action/skill_cast/self
execute if score #skill_select test.battle.skill_select matches 2 run function test:battle/action/skill_cast/projectile
