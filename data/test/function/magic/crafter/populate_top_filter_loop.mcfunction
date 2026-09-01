#> test:magic/crafter/populate_top_filter_loop
# registry_work.reverse_dst(combinedを反転させたもの)を末尾から取り出すと元の登録順になる。
# 習得済みのものだけ registry_work.top_known へ登録順のまま積み直す
# (#oh_my_dat:pleaseは呼び出し元(populate_top)でプレイヤーとして実行済み)

execute unless data storage test: registry_work.reverse_dst[-1] run return 0

data modify storage test: registry_work.top_check set from storage test: registry_work.reverse_dst[-1]
data remove storage test: registry_work.reverse_dst[-1]

execute as @p[distance=..6] run function test:magic/registry/known_check with storage test: registry_work.top_check
execute if score #known test.temporary matches 1 run data modify storage test: registry_work.top_known append from storage test: registry_work.top_check

function test:magic/crafter/populate_top_filter_loop
