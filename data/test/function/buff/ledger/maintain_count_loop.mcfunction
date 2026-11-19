#> test:buff/ledger/maintain_count_loop
# @macro = buff_ledger.arg。work.scan を読み切って、この付与元の段数を #lg_have に数える。
# 台帳には触らない(下見なので、連番が足りないときに何も壊さずに断れる)

execute unless data storage test: buff_ledger.work.scan[0] run return 0

data modify storage test: buff_ledger.work.c set from storage test: buff_ledger.work.scan[0]
data remove storage test: buff_ledger.work.scan[0]
$execute if data storage test: buff_ledger.work.c{src:"$(src)"} run scoreboard players add #lg_have test.buff.work 1

function test:buff/ledger/maintain_count_loop with storage test: buff_ledger.arg
