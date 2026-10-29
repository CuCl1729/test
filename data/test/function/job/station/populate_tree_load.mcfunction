#> test:job/station/populate_tree_load
# @s = Jobステーション本体。@macro id: 表示対象の職業id。そのskills[]を取り出し、data.job_ui.page 件を読み飛ばして
# ループへ渡す

$data modify storage test: registry_work.reverse_src set from storage test: asset.job.jobs[{id:"$(id)"}].skills
data remove storage test: registry_work.reverse_dst
function test:magic/registry/reverse_loop
data modify storage test: registry_work.tree_queue set from storage test: registry_work.reverse_dst

scoreboard players set #job_skip test.temporary 0
execute store result score #job_skip test.temporary run data get entity @s data.job_ui.page
function test:job/station/skip_tree

scoreboard players set #tree_slot test.temporary 1
$function test:job/station/populate_tree_loop {id:"$(id)"}
