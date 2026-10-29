#> test:battle/action/job_skill/handler/revive
# @s = 詠唱者(手番)。@macro mp_cost/percent/radius: このスキルのparams(radius はリアルタイム用で、ここでは使わない)。
# 同じ戦闘で倒れている味方を1人、HP percent% で起こす。相手がいなければ何も使わずに行動の選び直しに戻す

$execute store result score #revive_found test.temporary run function test:status/revive_pick {radius:$(radius)}
execute if score #revive_found test.temporary matches 0 run return run function test:battle/action/no_target

$scoreboard players set #mp_cost test.job.work $(mp_cost)
execute if score @s test.status.mp < #mp_cost test.job.work run tag @a remove revive_target
execute if score @s test.status.mp < #mp_cost test.job.work run tellraw @s [{text:"MPが足りません",color:gray}]
execute if score @s test.status.mp < #mp_cost test.job.work run return run function test:battle/turn_end
scoreboard players operation @s test.status.mp -= #mp_cost test.job.work

tellraw @a[distance=..64] ["",{selector:"@s"},{text:" のスキル！",color:gold}]
$execute as @a[tag=revive_target,limit=1] run function test:status/revive {percent:$(percent)}
tag @a remove revive_target

function test:battle/turn_end
