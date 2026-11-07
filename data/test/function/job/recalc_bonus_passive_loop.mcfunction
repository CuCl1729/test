#> test:job/recalc_bonus_passive_loop
# @s = 対象プレイヤー(please実行済み)。@macro job: 職業id。job_work.passive_queue(その職業のパッシブ)を末尾から取り出し、
# 取得済みのものの加算一覧を test.job_bonus.<stat> へ足す

execute unless data storage test: job_work.passive_queue[-1] run return 0

data modify storage test: job_work.passive_entry set from storage test: job_work.passive_queue[-1]
data remove storage test: job_work.passive_queue[-1]
$data modify storage test: job_work.passive_entry.job set value "$(job)"

function test:job/recalc_bonus_passive with storage test: job_work.passive_entry

$function test:job/recalc_bonus_passive_loop {job:"$(job)"}
