#> test:craft/magic/research/type
# @s = 研究するプレイヤー
# @macro type: 習得したい魔法タイプ (projectile|self)

$execute unless score @s test.magic.known.$(type) matches 1 run scoreboard players remove @s test.status.skill_point 1
$execute unless score @s test.magic.known.$(type) matches 1 run scoreboard players set @s test.magic.known.$(type) 1
