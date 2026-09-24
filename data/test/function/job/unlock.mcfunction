#> test:job/unlock
# @s = 解放しようとしているプレイヤー。@macro id: 解放する職業id
# 既に解放済みなら何もしない(進行状況を壊さないためのガード。craft/magic/research/learnと同じ形)

function #oh_my_dat:please

scoreboard players set #already test.job.work 0
$execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.unlocked.$(id) run scoreboard players set #already test.job.work 1

$execute if score #already test.job.work matches 0 run data modify storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.unlocked.$(id) set value 1b
$execute if score #already test.job.work matches 0 run data modify storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.data.$(id) set value {level:1,exp:0,skill_point:0,skills:{}}

function test:job/recalc_bonus
