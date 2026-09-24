#> test:job/requires_check_loop
# job_work.requires_queue(前提職業{job,level}のコピー)を末尾から取り出し、
# 1件でも未達なら#job_requires_ok test.job.workを0にする

execute unless data storage test: job_work.requires_queue[-1] run return 0

data modify storage test: job_work.requires_entry set from storage test: job_work.requires_queue[-1]
data remove storage test: job_work.requires_queue[-1]

function test:job/requires_check_entry with storage test: job_work.requires_entry

function test:job/requires_check_loop
