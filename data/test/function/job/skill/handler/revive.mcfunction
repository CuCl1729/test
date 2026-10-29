#> test:job/skill/handler/revive
# @s = 発動するプレイヤー(職業スキル、リアルタイム)。@macro mp_cost/percent/radius: このスキルのparams。
# radius 以内でダウンしている味方を1人、HP percent% で起こす。相手がいなければMPを払わない

$execute store result score #revive_found test.temporary run function test:status/revive_pick {radius:$(radius)}
execute if score #revive_found test.temporary matches 0 run return run tellraw @s [{text:"対象がいない",color:gray}]

$scoreboard players set #mp_cost test.job.work $(mp_cost)
execute if score @s test.status.mp < #mp_cost test.job.work run tag @a remove revive_target
execute if score @s test.status.mp < #mp_cost test.job.work run return run tellraw @s [{text:"MPが足りません",color:gray}]
scoreboard players operation @s test.status.mp -= #mp_cost test.job.work

$execute as @a[tag=revive_target,limit=1] run function test:status/revive {percent:$(percent)}
tag @a remove revive_target
