#> test:job/skill/eligibility_node_check
# @s = 判定対象のプレイヤー(please実行済み)。@macro id/job: 前提ノードid・職業id
# 未解放なら#job_skill_ok test.job.workを0にする

$execute unless data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.data.$(job).skills{$(id):1b} run scoreboard players set #job_skill_ok test.job.work 0
