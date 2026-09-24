#> test:job/skill/eligibility_node_loop
# job_work.node_queue(前提ノードidのコピー)を末尾から取り出し、1つでも未解放なら
# #job_skill_ok test.job.workを0にする。職業idはjob_work.skill_entry.jobから毎回引く
# (このループ中はskill_entry自体を書き換えないので安全に参照できる)

execute unless data storage test: job_work.node_queue[-1] run return 0

data modify storage test: job_work.node_check set value {id:"",job:""}
data modify storage test: job_work.node_check.id set from storage test: job_work.node_queue[-1]
data modify storage test: job_work.node_check.job set from storage test: job_work.skill_entry.job
data remove storage test: job_work.node_queue[-1]

function test:job/skill/eligibility_node_check with storage test: job_work.node_check

function test:job/skill/eligibility_node_loop
