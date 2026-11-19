#> test:buff/ledger/fold_loop
# イベント占有を先頭から1件ずつバッチへ畳む。
# 先頭から処理するので、バッチの並びは「そのバッチの最初の1件が起きた順」になる
# (押し出しのexpireが新しい段のapplyより先、周期・タイマーが終了より先、が自然に保たれる)

execute unless data storage test: buff_ledger.work.occ[0] run return 0

data modify storage test: buff_ledger.work.o set from storage test: buff_ledger.work.occ[0]
data remove storage test: buff_ledger.work.occ[0]

function test:buff/ledger/fold_one with storage test: buff_ledger.work.o

function test:buff/ledger/fold_loop
