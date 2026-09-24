#> test:job/grant_exp_entry
# @s = 対象プレイヤー(please実行済み)。@macro id: 職業レジストリ1件ぶん(job_work.exp_entryとして
# 展開済み)。未解放ならスキップ、解放済みなら#reward test.temporaryぶんEXPを加算しレベルアップ判定

scoreboard players set #unlocked test.job.work 0
$execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.unlocked.$(id) run scoreboard players set #unlocked test.job.work 1
execute if score #unlocked test.job.work matches 0 run return 0

scoreboard players set #exp test.job.work 0
$execute store result score #exp test.job.work run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.data.$(id).exp
scoreboard players operation #exp test.job.work += #reward test.temporary
$execute store result storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.data.$(id).exp int 1 run scoreboard players get #exp test.job.work

function test:job/level_up with storage test: job_work.exp_entry
