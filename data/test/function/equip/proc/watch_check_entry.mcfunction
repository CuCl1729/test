#> test:equip/proc/watch_check_entry
# @macro id: しきい値型のイベント。その枠を持っている(タグ equip_watch.<id>)ときだけ比べる

$execute if entity @s[tag=equip_watch.$(id)] run function test:equip/proc/watch_below with storage test: equip_work.watch_cur
