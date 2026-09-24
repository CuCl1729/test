#> test:job/skill/use
# @s = 発動するプレイヤー。@macro job/node: 職業id・ノードid。レジストリから該当ノードを読み、
# kind/paramsをそのままハンドラ(test:job/skill/handler/<kind>)へ渡して呼ぶ

$function test:job/skill/load_entry {job:"$(job)",node:"$(node)"}

function test:job/skill/dispatch with storage test: job_work.skill_entry
