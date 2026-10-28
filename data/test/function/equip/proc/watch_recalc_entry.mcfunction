#> test:equip/proc/watch_recalc_entry
# @s = プレイヤー。@macro id: しきい値型のイベント。その枠に中身があれば見張り、無ければ見張りと「下回り中」のタグを外す

$execute if data storage test: equip_work.procs[{event:"$(id)"}] run tag @s add equip_watch.$(id)
$execute if data storage test: equip_work.procs[{event:"$(id)"}] run return run scoreboard players set @s test.equip.has_watch 1

$tag @s remove equip_watch.$(id)
$tag @s remove equip_below.$(id)
