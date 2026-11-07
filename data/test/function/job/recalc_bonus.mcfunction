#> test:job/recalc_bonus
# @s = 対象プレイヤー(please実行済みであること)。解放済みの全職業のgrowth×現在レベルと、取得済みのパッシブ
# (stat_bonus)を合算して test.job_bonus.<stat> をゼロから組み立て直す(test.buff.<stat>と同じくstatus/updateの最後で
# 加算される)。毎回ゼロからなので何度呼んでも重ならない。実効ステータスまで直すときは test:job/refresh_bonus

scoreboard players set @s test.job_bonus.atk 0
scoreboard players set @s test.job_bonus.def 0
scoreboard players set @s test.job_bonus.hp_max 0
scoreboard players set @s test.job_bonus.mp_max 0
scoreboard players set @s test.job_bonus.crit_rate 0
scoreboard players set @s test.job_bonus.crit_damage 0
scoreboard players set @s test.job_bonus.effect_damage 0
scoreboard players set @s test.job_bonus.magic_efficiency 0
scoreboard players set @s test.job_bonus.divergence 0
scoreboard players set @s test.job_bonus.hp_regene 0
scoreboard players set @s test.job_bonus.mp_regene 0

data modify storage test: job_work.recalc_queue set from storage test: asset.job.jobs

function test:job/recalc_bonus_loop
