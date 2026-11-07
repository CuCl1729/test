#> test:job/reset/names_loop
# @s = プレイヤー(please実行済み)。@macro job: 職業id。job_work.reset_queue(その職業のスキル)を先頭から見て、
# 取得済みの名前を job_work.reset_names へ足す

execute unless data storage test: job_work.reset_queue[0] run return 0
data modify storage test: job_work.reset_entry set from storage test: job_work.reset_queue[0]
data remove storage test: job_work.reset_queue[0]
$data modify storage test: job_work.reset_entry.job set value "$(job)"
function test:job/reset/names_entry with storage test: job_work.reset_entry
$function test:job/reset/names_loop {job:"$(job)"}
