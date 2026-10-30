#> test:machine/port/out/push
# @s = 機械のマーカー。@macro x/y/z: 搬出口の、核からのずれ(machine_work.push。送り先は tx/ty/tz)。
# 搬出口の中身を1スロットずつ、送り先に送る(1秒に16個まで)

scoreboard players set #push_budget test.temporary 16
data modify storage test: machine_work.push_items set value []
$execute at @s positioned ~$(x) ~$(y) ~$(z) run data modify storage test: machine_work.push_items set from block ~ ~ ~ Items
function test:machine/port/out/push_item_loop
