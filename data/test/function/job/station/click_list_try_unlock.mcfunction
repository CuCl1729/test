#> test:job/station/click_list_try_unlock
# @s = ステーションの近くにいるプレイヤー。@macro id: クリックされた職業id
# 前提を満たしていて未解放なら解放する(既に解放済みならtest:job/unlock自身が何もしない)

function #oh_my_dat:please

$function test:job/requires_check {id:"$(id)"}
execute if score #job_requires_ok test.job.work matches 0 run return 0

$function test:job/unlock {id:"$(id)"}
