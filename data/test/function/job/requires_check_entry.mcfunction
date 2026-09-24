#> test:job/requires_check_entry
# @s = 判定対象のプレイヤー(please実行済み)。@macro job/level: 前提職業1件ぶん
# (job_work.requires_entryとして展開済み)。プレイヤーのその職業のレベル(未解放なら0扱い)が
# 足りていなければ#job_requires_ok test.job.workを0にする

scoreboard players set #have test.job.work 0
$execute store result score #have test.job.work run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.data.$(job).level

scoreboard players set #need test.job.work 0
execute store result score #need test.job.work run data get storage test: job_work.requires_entry.level

execute if score #have test.job.work < #need test.job.work run scoreboard players set #job_requires_ok test.job.work 0
