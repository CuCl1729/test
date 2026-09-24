#> test:job/recalc_bonus_growth_entry
# @s = 対象プレイヤー。@macro stat: growth1件ぶんのステータス名。#level test.job.work
# (呼び出し元recalc_bonus_entryが設定済み)を掛けてtest.job_bonus.<stat>へ加算する

scoreboard players set #amount test.job.work 0
execute store result score #amount test.job.work run data get storage test: job_work.growth_entry.per_level
scoreboard players operation #amount test.job.work *= #level test.job.work

$scoreboard players operation @s test.job_bonus.$(stat) += #amount test.job.work
