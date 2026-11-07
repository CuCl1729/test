#> test:job/reset/names_entry
# @s = プレイヤー(please実行済み)。@macro job/id: 職業id・ノードid

$execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.data.$(job).skills{$(id):1b} run data modify storage test: job_work.reset_names append from storage test: job_work.reset_entry.label
