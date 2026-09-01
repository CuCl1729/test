#> test:buff/step
# @s = バフ保持者。#buff_step test.buff.work で指定した秒数ぶん時間を進める
# (リアルタイムは1秒ごとに1、ターン制は保持者の手番終了時に10。継続時間を常に「秒」で持つことで
#  「ターン制の継続時間 = アクション制の秒数/10ターン」が換算処理なしで成り立つ)
#
# 「データを確定させてからイベントを発火する」2段構えにしている。イベント関数の中から
# buff/applyやbuff/clearが呼ばれても、個別ストレージが既に書き戻し済みなので矛盾しない

function test:buff/load

data modify storage test: buff_work.out set value []
function test:buff/step_loop

# step_loopは末尾から取り出すため順序が反転している。表示順を保つよう戻してから書き戻す
data modify storage test: buff_work.list set value []
function test:buff/restore_loop

function test:buff/save
function test:buff/refresh_icons

function test:buff/fire_loop
