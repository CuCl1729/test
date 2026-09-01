#> test:magic/crafter/populate_top_skip
# registry_work.top_known の先頭から #top_skip 件だけ捨てる(ページ送り)。
# 表示側(populate_top_slot_loop)は先頭[0]から使うため、読み飛ばしも先頭[0]から行うこと
# (末尾[-1]から捨てると、残るのが「後半の表示すべき要素」ではなく「前半の元々あった要素」に
#  なってしまい、2ページ目以降の表示が壊れる。要素数は多くても数十件程度なので[0]除去のコストは無視できる)

execute unless score #top_skip test.buff.work matches 1.. run return 0
execute unless data storage test: registry_work.top_known[0] run return 0

data remove storage test: registry_work.top_known[0]
scoreboard players remove #top_skip test.buff.work 1

function test:magic/crafter/populate_top_skip
