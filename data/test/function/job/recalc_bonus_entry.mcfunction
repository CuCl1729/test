#> test:job/recalc_bonus_entry
# @s = 対象プレイヤー(please実行済み)。@macro id: 職業レジストリ1件ぶん(job_work.recalc_entryとして
# 展開済み、growthも同じコンパウンドに入っている)。未解放ならスキップする

scoreboard players set #unlocked test.job.work 0
$execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.unlocked.$(id) run scoreboard players set #unlocked test.job.work 1
execute if score #unlocked test.job.work matches 0 run return 0

scoreboard players set #level test.job.work 0
$execute store result score #level test.job.work run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.data.$(id).level

data modify storage test: job_work.growth_queue set from storage test: job_work.recalc_entry.growth
function test:job/recalc_bonus_growth_loop
