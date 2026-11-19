#> test:buff/clear
# @s = 対象。@macro reason: 外す理由(今は使わない。呼び出し元の目印として受け取る)
# 掛かっているものを全部外す(ダウン時・戦闘の終わり・戦闘状態のリセット)。終了イベントは出る
data modify storage test: buff_runtime.arg set value {op:"clear"}
return run function test:buff/op
