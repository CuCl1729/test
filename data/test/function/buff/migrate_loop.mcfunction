#> test:buff/migrate_loop
# 内部。@s = 受け手。古い一覧(mig.list)の先頭のバフを付け直す。
# 付与元の内訳(src)があればキーごとに、無ければ全体を「ふつうの付与」として
execute unless data storage test: buff_work.mig.list[0] run return 0
data modify storage test: buff_work.mig.one set from storage test: buff_work.mig.list[0]
data remove storage test: buff_work.mig.list[0]

execute unless data storage test: buff_work.mig.one.src[0] run data modify storage test: buff_work.mig.one.src set value [{k:"-",stacks:1,remaining:1}]
execute unless data storage test: buff_work.mig.one.src[1] if data storage test: buff_work.mig.one.src[{k:"-"}] run data modify storage test: buff_work.mig.one.src[0].stacks set from storage test: buff_work.mig.one.stacks
execute unless data storage test: buff_work.mig.one.src[1] if data storage test: buff_work.mig.one.src[{k:"-"}] if data storage test: buff_work.mig.one.remaining run data modify storage test: buff_work.mig.one.src[0].remaining set from storage test: buff_work.mig.one.remaining
function test:buff/migrate_life with storage test: buff_work.mig.one
function test:buff/migrate_src

function test:buff/migrate_loop
