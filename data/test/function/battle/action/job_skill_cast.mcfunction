#> test:battle/action/job_skill_cast
# @s = 詠唱者(手番)。@macro job/node: 選ばれた職業スキル参照。レジストリからkind/paramsを引いて
# 対応するターン制ハンドラ(test:battle/action/job_skill/handler/<kind>)へparamsを渡して呼ぶ

execute unless function test:battle/ui/current_actor run return 0
function #oh_my_dat:please
$execute unless data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.data.$(job).skills{$(node):1b} run return 0
$execute store result score #job_active test.job.work run function test:job/skill/is_active {job:"$(job)",node:"$(node)"}
execute if score #job_active test.job.work matches 0 run return run function test:battle/action/passive_refused
$function test:job/skill/load_entry {job:"$(job)",node:"$(node)"}

function test:battle/action/job_skill_dispatch with storage test: job_work.skill_entry
