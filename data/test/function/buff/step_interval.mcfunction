#> test:buff/step_interval
# @macro = バフインスタンス1件。繰り返しイベントを1回だけ予約し、次回の発火時刻を経過時間の先へ進める

$data modify storage test: buff_work.fire append value {event:"interval",id:"$(id)",stacks:$(stacks),reason:"tick",at:0}
execute store result storage test: buff_work.fire[-1].at int 1 run scoreboard players get #elapsed test.buff.work

scoreboard players set #interval test.buff.work 0
$execute store result score #interval test.buff.work run data get storage test: asset.buff.types[{id:"$(id)"}].interval
execute if score #interval test.buff.work matches ..0 run scoreboard players set #interval test.buff.work 1

function test:buff/step_interval_advance
