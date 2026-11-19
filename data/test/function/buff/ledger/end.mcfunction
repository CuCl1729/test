#> test:buff/ledger/end
# 各操作の最後に呼ぶ。積んだイベント占有をバッチへ畳んで、作業領域を片付ける。
# 実際の発火はしない(呼び出し側が events を見て1バッチにつき1回だけ実行する)

function test:buff/ledger/fold_loop

execute if score #lg_seq test.buff.work matches 0.. store result storage test: buff_ledger.next_seq int 1 run scoreboard players get #lg_seq test.buff.work

data remove storage test: buff_ledger.work
