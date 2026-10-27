#> test:equip/proc/run_all
# @s = 自動発動の予約があるプレイヤー。一覧を作業用に写して1件ずつ見る

function #oh_my_dat:please
data modify storage test: equip_work.proc_queue set from storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.equip.procs
function test:equip/proc/run_loop
