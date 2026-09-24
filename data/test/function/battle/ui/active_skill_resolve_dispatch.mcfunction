#> test:battle/ui/active_skill_resolve_dispatch
# @s = アクティブスキルを選んだプレイヤー(チャット式)。@macro kind(+job/node): 選ばれた1件
# (registry_work.active_resolve_entryとして展開済み)

execute if data storage test: registry_work.active_resolve_entry{kind:"sword"} run function test:battle/action/job_skill/sword_cast
$execute if data storage test: registry_work.active_resolve_entry{kind:"job"} run function test:battle/action/job_skill_cast {job:"$(job)",node:"$(node)"}
