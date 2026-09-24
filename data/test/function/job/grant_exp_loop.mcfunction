#> test:job/grant_exp_loop
# job_work.exp_queue(職業レジストリのコピー)を末尾から取り出し、解放済みならEXPを与える

execute unless data storage test: job_work.exp_queue[-1] run return 0

data modify storage test: job_work.exp_entry set from storage test: job_work.exp_queue[-1]
data remove storage test: job_work.exp_queue[-1]

function test:job/grant_exp_entry with storage test: job_work.exp_entry

function test:job/grant_exp_loop
