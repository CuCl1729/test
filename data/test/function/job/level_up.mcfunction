#> test:job/level_up
# @s = 対象プレイヤー(please実行済み)。@macro id: 職業id。exp_coefficient省略時は50を使う
# (test.status.exp用のlevel^2*50と同じ曲線を既定にする)。要求EXP(level^2*coefficient)を
# 満たしていればレベルアップしてスキルポイントを1増やし、再帰する(status/level_up.mcfunctionのoh_my_dat版)

scoreboard players set #coefficient test.job.work 50
execute store result score #coefficient test.job.work run data get storage test: job_work.exp_entry.exp_coefficient

scoreboard players set #level test.job.work 0
$execute store result score #level test.job.work run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.data.$(id).level

scoreboard players operation #required test.job.work = #level test.job.work
scoreboard players operation #required test.job.work *= #level test.job.work
scoreboard players operation #required test.job.work *= #coefficient test.job.work

scoreboard players set #exp test.job.work 0
$execute store result score #exp test.job.work run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.data.$(id).exp

scoreboard players set #can_level test.job.work 0
execute if score #exp test.job.work >= #required test.job.work run scoreboard players set #can_level test.job.work 1
execute if score #can_level test.job.work matches 0 run return 0

scoreboard players operation #exp test.job.work -= #required test.job.work
$execute store result storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.data.$(id).exp int 1 run scoreboard players get #exp test.job.work

scoreboard players add #level test.job.work 1
$execute store result storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.data.$(id).level int 1 run scoreboard players get #level test.job.work

scoreboard players set #point test.job.work 0
$execute store result score #point test.job.work run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.data.$(id).skill_point
scoreboard players add #point test.job.work 1
$execute store result storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.data.$(id).skill_point int 1 run scoreboard players get #point test.job.work

function test:job/level_up with storage test: job_work.exp_entry
