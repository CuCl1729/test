#> test:battle/ui/skill_resolve
# @s = 魔法タイプを選択したプレイヤー(チャット式)

scoreboard players operation @s test.battle.skill_type = @s test.battle.skill_select
scoreboard players set @s test.battle.skill_select 0

function test:battle/ui/skill_effect_select
