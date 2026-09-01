#> test:buff/step_entry
# @macro = バフインスタンス1件 {id,remaining,elapsed,stacks,next_interval?,timers?}
# 残り時間と経過時間を進め、発火すべきイベントを buff_work.fire へ「積むだけ」積む
# (実際の発火は個別ストレージへ書き戻したあと。test:buff/step 参照)

$scoreboard players set #remaining test.buff.work $(remaining)
$scoreboard players set #elapsed test.buff.work $(elapsed)

scoreboard players operation #remaining test.buff.work -= #buff_step test.buff.work
scoreboard players operation #elapsed test.buff.work += #buff_step test.buff.work

# 一度きりのタイマー: 経過時間を越えたぶんをすべて予約する(昇順に並んでいる前提)
data modify storage test: buff_work.timers set value []
execute if data storage test: buff_work.entry.timers run data modify storage test: buff_work.timers set from storage test: buff_work.entry.timers
execute if data storage test: buff_work.timers[0] run function test:buff/step_timer_loop with storage test: buff_work.entry

# 繰り返し: 1ステップにつき最大1回。ターン制は1手番で10秒進むため、
# intervalが10以下のバフは毎手番きっちり1回の発火になる
scoreboard players set #next test.buff.work 0
execute store result score #next test.buff.work run data get storage test: buff_work.entry.next_interval
execute if score #next test.buff.work matches 1.. if score #next test.buff.work <= #elapsed test.buff.work run function test:buff/step_interval with storage test: buff_work.entry

# まだ残っていれば進めた値で積み直し、尽きていれば終了イベントを予約する
execute if score #remaining test.buff.work matches 1.. run data modify storage test: buff_work.out append from storage test: buff_work.entry
execute if score #remaining test.buff.work matches 1.. store result storage test: buff_work.out[-1].remaining int 1 run scoreboard players get #remaining test.buff.work
execute if score #remaining test.buff.work matches 1.. store result storage test: buff_work.out[-1].elapsed int 1 run scoreboard players get #elapsed test.buff.work
execute if score #remaining test.buff.work matches 1.. if data storage test: buff_work.entry.next_interval store result storage test: buff_work.out[-1].next_interval int 1 run scoreboard players get #next test.buff.work
execute if score #remaining test.buff.work matches 1.. if data storage test: buff_work.entry.timers run data modify storage test: buff_work.out[-1].timers set from storage test: buff_work.timers

$execute if score #remaining test.buff.work matches ..0 run data modify storage test: buff_work.fire append value {event:"expire",id:"$(id)",stacks:$(stacks),reason:"expire",at:0}
