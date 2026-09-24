#> test:battle/action/job_skill_cast
# @s = 詠唱者(手番)。@macro job/node: 選ばれた職業スキル参照。レジストリからkind/paramsを引いて
# 対応するターン制ハンドラ(test:battle/action/job_skill/handler/<kind>)へparamsを渡して呼ぶ

$function test:job/skill/load_entry {job:"$(job)",node:"$(node)"}

function test:battle/action/job_skill_dispatch with storage test: job_work.skill_entry
