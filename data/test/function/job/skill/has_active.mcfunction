#> test:job/skill/has_active
# @s = プレイヤー(please実行済み)。skill_order に発動できるスキルが1つでもあれば1を返す

data modify storage test: job_work.active_queue set from storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.skill_order
return run function test:job/skill/has_active_loop
