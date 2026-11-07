#> test:job/recalc_bonus_growth_entry
# @s = 対象プレイヤー。@macro stat: 加算1件({stat, amount})のステータス名。amount に #level test.job.work
# (成長ならその職業のレベル、パッシブなら1)を掛けて test.job_bonus.<stat> へ加算する

scoreboard players set #amount test.job.work 0
execute store result score #amount test.job.work run data get storage test: job_work.growth_entry.amount
scoreboard players operation #amount test.job.work *= #level test.job.work

$scoreboard players operation @s test.job_bonus.$(stat) += #amount test.job.work
