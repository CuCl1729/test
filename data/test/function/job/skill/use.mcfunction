#> test:job/skill/use
# @s = 発動するプレイヤー。@macro job/node: 職業id・ノードid。レジストリから該当ノードを読み、
# kind/paramsをそのままハンドラ(test:job/skill/handler/<kind>)へ渡して呼ぶ

# ダウン中は使えない
execute if entity @s[tag=downed] run return 0
# パッシブ(stat_bonus)は発動しない(パッシブに変わる前に作られた古い印アイテムから呼ばれても何もしない)
$execute store result score #job_active test.job.work run function test:job/skill/is_active {job:"$(job)",node:"$(node)"}
execute if score #job_active test.job.work matches 0 run return 0

$function test:job/skill/load_entry {job:"$(job)",node:"$(node)"}

function test:job/skill/dispatch with storage test: job_work.skill_entry
