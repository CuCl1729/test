#> test:craft/magic/research/populate_top_collect_loop
# registry_work.reverse_dst(combinedを反転させたもの)を末尾から取り出すと元の登録順になる。
# 研究では習得済みかどうかを問わず全件を registry_work.top_known へそのまま積み直す

execute unless data storage test: registry_work.reverse_dst[-1] run return 0

data modify storage test: registry_work.top_known append from storage test: registry_work.reverse_dst[-1]
data remove storage test: registry_work.reverse_dst[-1]

function test:craft/magic/research/populate_top_collect_loop
