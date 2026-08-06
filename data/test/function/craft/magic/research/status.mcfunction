#> test:craft/magic/research/status
# @s = 研究するプレイヤー
# @macro status: 習得したい魔法ステータス強化 (atk)

$execute unless score @s test.magic.known.$(status) matches 1 run scoreboard players remove @s test.status.skill_point 1
$execute unless score @s test.magic.known.$(status) matches 1 run scoreboard players set @s test.magic.known.$(status) 1
