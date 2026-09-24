#> test:job/skill/unlock
# @s = 職業ステーションでポイントを割り振ろうとしているプレイヤー。@macro job/node: 職業id・ノードid
# 解放可否を再検証してから、スキルポイントを消費してそのノードを解放し、スキルバンドルを再同期する

function #oh_my_dat:please

$function test:job/skill/load_entry {job:"$(job)",node:"$(node)"}

scoreboard players set #already test.job.work 0
$execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.data.$(job).skills{$(node):1b} run scoreboard players set #already test.job.work 1
execute if score #already test.job.work matches 1 run return 0

function test:job/skill/eligibility_check with storage test: job_work.skill_entry
execute if score #job_skill_ok test.job.work matches 0 run return 0

scoreboard players set #point test.job.work 0
$execute store result score #point test.job.work run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.data.$(job).skill_point
scoreboard players set #cost test.job.work 0
execute store result score #cost test.job.work run data get storage test: job_work.skill_entry.cost
scoreboard players operation #point test.job.work -= #cost test.job.work
$execute store result storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.data.$(job).skill_point int 1 run scoreboard players get #point test.job.work

$data modify storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.data.$(job).skills.$(node) set value 1b

data modify storage test: job_work.new_skill_ref set value {job:"",node:""}
$data modify storage test: job_work.new_skill_ref.job set value "$(job)"
$data modify storage test: job_work.new_skill_ref.node set value "$(node)"
data modify storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.skill_order append from storage test: job_work.new_skill_ref

function test:job/bundle/rebuild
