#> test:buff/step
# @s = バフ保持者。#buff_step test.buff.work で指定した秒数ぶん時間を進める
# (リアルタイムは1秒ごとに1、ターン制は保持者の手番終了時に10。継続時間を常に「秒」で持つことで
#  「ターン制の継続時間 = アクション制の秒数/10ターン」が換算処理なしで成り立つ)。
# 一定間隔の効果は、1回の進行で多くても1回だけ出る
data modify storage test: buff_runtime.arg set value {op:"advance",step:1}
execute store result storage test: buff_runtime.arg.step int 1 run scoreboard players get #buff_step test.buff.work
return run function test:buff/op
