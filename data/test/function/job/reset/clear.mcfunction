#> test:job/reset/clear
# @s = プレイヤー。確認待ちを消し、確認ボタンを押せなくする

function #oh_my_dat:please
data remove storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.reset
tag @s remove job_reset_pending
scoreboard players reset @s test.job_reset
