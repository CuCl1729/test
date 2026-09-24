#> test:job/recalc_bonus_growth_loop
# job_work.growth_queue(1職業ぶんのgrowthのコピー)を末尾から取り出し、
# #level test.job.work(呼び出し元recalc_bonus_entryが設定済み)を掛けてjob_bonus.<stat>へ加算する

execute unless data storage test: job_work.growth_queue[-1] run return 0

data modify storage test: job_work.growth_entry set from storage test: job_work.growth_queue[-1]
data remove storage test: job_work.growth_queue[-1]

function test:job/recalc_bonus_growth_entry with storage test: job_work.growth_entry

function test:job/recalc_bonus_growth_loop
