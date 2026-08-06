#> test:craft/magic/research/effect
# @s = 研究するプレイヤー
# @macro effect: 習得したい魔法効果 (fire|gravity|heal)

$execute unless score @s test.magic.known.$(effect) matches 1 run scoreboard players remove @s test.status.skill_point 1
$execute unless score @s test.magic.known.$(effect) matches 1 run scoreboard players set @s test.magic.known.$(effect) 1
