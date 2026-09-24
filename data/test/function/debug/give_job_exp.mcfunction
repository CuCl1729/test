#> test:debug/give_job_exp
# @s(プレイヤー)の指定した職業へEXPを直接付与する(戦闘なしでレベルアップ検証するための試験用)。
# @macro job: 職業id / amount: 付与するEXP量
# test:job/level_up はexp_coefficientをjob_work.exp_entry(固定パス)から読むので、
# test:job/grant_exp_entryと同じ形でそこへ職業レジストリの1件を丸ごと複製してから呼ぶ

function #oh_my_dat:please

scoreboard players set #exp test.job.work 0
$execute store result score #exp test.job.work run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.data.$(job).exp
$scoreboard players add #exp test.job.work $(amount)
$execute store result storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.data.$(job).exp int 1 run scoreboard players get #exp test.job.work

$data modify storage test: job_work.exp_entry set from storage test: asset.job.jobs[{id:"$(job)"}]

function test:job/level_up with storage test: job_work.exp_entry
