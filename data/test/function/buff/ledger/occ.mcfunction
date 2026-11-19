#> test:buff/ledger/occ
# @macro = buff_ledger.work.ev {id,event,reason}。work.u の段1件ぶんをイベント占有として積む。
# n = この1回の処理の中で、その段にとって何回目の発生か(既定1)。
# 同じ処理の中で起きたことは同じ世界時刻なので、段ごとの経過時間が違っても n が同じなら同じ機会。
# 大きく時間が飛んで複数のタイマー地点を跨いだときだけ n が増えて別の機会になる

$data modify storage test: buff_ledger.work.occ append value {id:"$(id)",event:"$(event)",reason:"$(reason)",n:1,unit:{}}
data modify storage test: buff_ledger.work.occ[-1].unit set from storage test: buff_ledger.work.u
