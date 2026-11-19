#> test:magic/combo/match_loop
# combo_work.queue を先頭から1行ずつ見て、最初に当たった行で止まる。
# 同時に成立しうる行で結果が食い違うものは生成時に弾いてあるので、どれが先かは結果を変えない
execute unless data storage test: combo_work.queue[0] run return 0

data modify storage test: combo_work.row set from storage test: combo_work.queue[0]
data remove storage test: combo_work.queue[0]
function test:magic/combo/match_row with storage test: combo_work.row

execute if score #combo_found test.temporary matches 1 run return 1
function test:magic/combo/match_loop
