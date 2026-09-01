#> test:buff/remove
# @s = 対象。@macro id: 外すバフid / reason: 終了イベントに渡す理由文字列

function test:buff/load

scoreboard players set #old_stacks test.buff.work 0
$execute store result score #old_stacks test.buff.work run data get storage test: buff_work.list[{id:"$(id)"}].stacks
execute if score #old_stacks test.buff.work matches ..0 run return 0

$data remove storage test: buff_work.list[{id:"$(id)"}]

function test:buff/save
function test:buff/refresh_icons

$data modify storage test: buff_work.fire append value {event:"expire",id:"$(id)",stacks:1,reason:"$(reason)",at:0}
execute store result storage test: buff_work.fire[-1].stacks int 1 run scoreboard players get #old_stacks test.buff.work

function test:buff/fire_loop
