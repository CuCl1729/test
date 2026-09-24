#> test:job/skill/eligibility_check
# @s = 判定対象のプレイヤー(please実行済み)。呼び出し前にjob_work.skill_entryへ
# test:job/skill/load_entryで対象ノードを読み込んでおくこと。@macro job: そのノードが属する職業id
# (oh_my_datパスの構築にだけ使う)。解放可否を#job_skill_ok test.job.workへ0/1で返す
# (既に解放済みかどうかはここでは見ない。呼び出し元で除外すること)

scoreboard players set #job_skill_ok test.job.work 1

scoreboard players set #have_level test.job.work 0
$execute store result score #have_level test.job.work run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.data.$(job).level
scoreboard players set #need_level test.job.work 0
execute store result score #need_level test.job.work run data get storage test: job_work.skill_entry.requires_level
execute if score #have_level test.job.work < #need_level test.job.work run scoreboard players set #job_skill_ok test.job.work 0

scoreboard players set #have_point test.job.work 0
$execute store result score #have_point test.job.work run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.data.$(job).skill_point
scoreboard players set #need_point test.job.work 0
execute store result score #need_point test.job.work run data get storage test: job_work.skill_entry.cost
execute if score #have_point test.job.work < #need_point test.job.work run scoreboard players set #job_skill_ok test.job.work 0

data modify storage test: job_work.node_queue set from storage test: job_work.skill_entry.requires_nodes
function test:job/skill/eligibility_node_loop
