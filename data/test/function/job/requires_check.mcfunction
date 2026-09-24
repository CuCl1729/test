#> test:job/requires_check
# @s = 判定対象のプレイヤー(呼び出し前にfunction #oh_my_dat:pleaseを@sとして実行済みであること)
# @macro id: 判定したい職業id。結果を #job_requires_ok test.job.work へ0/1で返す
# (asset.job.jobs[id].requiresの各{job,level}を全て満たしているか)

scoreboard players set #job_requires_ok test.job.work 1

data remove storage test: job_work.requires_queue
$data modify storage test: job_work.requires_queue set from storage test: asset.job.jobs[{id:"$(id)"}].requires

function test:job/requires_check_loop
