#> test:job/recalc_bonus_passive
# @s = 対象プレイヤー(please実行済み)。@macro job/id: パッシブ1件(job_work.passive_entry)。取得済みなら bonus を1倍で足す

$execute unless data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.data.$(job).skills{$(id):1b} run return 0

scoreboard players set #level test.job.work 1
data modify storage test: job_work.growth_queue set from storage test: job_work.passive_entry.bonus
function test:job/recalc_bonus_growth_loop
