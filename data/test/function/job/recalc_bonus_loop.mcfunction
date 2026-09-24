#> test:job/recalc_bonus_loop
# job_work.recalc_queue(職業レジストリのコピー)を末尾から取り出し、解放済みならgrowthを積み上げる

execute unless data storage test: job_work.recalc_queue[-1] run return 0

data modify storage test: job_work.recalc_entry set from storage test: job_work.recalc_queue[-1]
data remove storage test: job_work.recalc_queue[-1]

function test:job/recalc_bonus_entry with storage test: job_work.recalc_entry

function test:job/recalc_bonus_loop
