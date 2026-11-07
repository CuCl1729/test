#> test:job/reset/press
# @s = /trigger test.job_reset を押したプレイヤー(test:tick から)。今の確認待ちの番号のボタンなら、
# 確認待ちを消してから実行(1)かキャンセル(2)をする。古いボタンなら何もせず、今のボタンを押せるようにしておく

function #oh_my_dat:please
scoreboard players operation #rp test.temporary = @s test.job_reset
scoreboard players set @s test.job_reset 0
execute unless data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.reset run return 0
scoreboard players enable @s test.job_reset

scoreboard players operation #rseq test.temporary = #rp test.temporary
scoreboard players operation #rseq test.temporary /= #10 test.constant
scoreboard players operation #rp test.temporary %= #10 test.constant
execute store result score #rs test.temporary run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.reset.seq
execute unless score #rseq test.temporary = #rs test.temporary run return 0

data modify storage test: job_work.reset_pending set from storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.reset
function test:job/reset/clear
execute if score #rp test.temporary matches 2 run return run tellraw @s {text:"リセットをやめた",color:"gray"}
execute if score #rp test.temporary matches 1 run function test:job/reset/run with storage test: job_work.reset_pending
