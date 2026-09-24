#> test:battle/ui/skill_category_resolve
# @s = 2択を選んだプレイヤー(チャット式)

scoreboard players operation #choice test.battle.skill_category = @s test.battle.skill_category
scoreboard players set @s test.battle.skill_category 0
scoreboard players set @e[tag=battle_marker,sort=nearest,limit=1] test.battle.awaiting_skill 0

execute if score #choice test.battle.skill_category matches 1 run function test:battle/action/skill_magic_only
execute if score #choice test.battle.skill_category matches 2 run function test:battle/action/active_skill_select
