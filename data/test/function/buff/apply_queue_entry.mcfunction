#> test:buff/apply_queue_entry
# @s = 付与対象。@macro = 付与する1件 {id,stacks} (+ 任意で chance)
# chance を書いた場合はその確率(%)でだけ付与する。書かなければ必ず付与する

# chanceが書かれていなければ100%。既定値を潰さないよう、キーがある場合だけ読み込むこと
# (execute store resultは「コマンドが失敗したら0を書き込む」ため、
#  data getの失敗まかせにすると確率0%になって一切付与されなくなる)
scoreboard players set #chance test.buff.work 100
execute if data storage test: buff_work.queue_entry.chance store result score #chance test.buff.work run data get storage test: buff_work.queue_entry.chance

scoreboard players set #roll test.buff.work 0
execute store result score #roll test.buff.work run random value 1..100
execute if score #roll test.buff.work > #chance test.buff.work run return 0

$function test:buff/apply {id:"$(id)",stacks:$(stacks)}
