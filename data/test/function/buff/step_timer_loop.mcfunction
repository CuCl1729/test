#> test:buff/step_timer_loop
# @macro = バフインスタンス1件。buff_work.timers の先頭が #elapsed を過ぎていれば発火を予約して取り除く。
# 1ステップで複数のタイマーを跨いだ場合は、跨いだぶんすべて発火する(それぞれ別のイベントのため)

execute unless data storage test: buff_work.timers[0] run return 0

scoreboard players set #at test.buff.work 0
execute store result score #at test.buff.work run data get storage test: buff_work.timers[0]
execute if score #at test.buff.work > #elapsed test.buff.work run return 0

data remove storage test: buff_work.timers[0]

$data modify storage test: buff_work.fire append value {event:"timer",id:"$(id)",stacks:$(stacks),reason:"tick",at:0}
execute store result storage test: buff_work.fire[-1].at int 1 run scoreboard players get #at test.buff.work

function test:buff/step_timer_loop with storage test: buff_work.entry
