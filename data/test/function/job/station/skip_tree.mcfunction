#> test:job/station/skip_tree
# registry_work.tree_queue(末尾から使う)を、末尾から #job_skip 件だけ捨てる(ページ送り)

execute unless score #job_skip test.temporary matches 1.. run return 0
execute unless data storage test: registry_work.tree_queue[-1] run return 0
data remove storage test: registry_work.tree_queue[-1]
scoreboard players remove #job_skip test.temporary 1
function test:job/station/skip_tree
