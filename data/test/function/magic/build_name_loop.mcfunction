#> test:magic/build_name_loop
# registry_work.reverse_dst(元のbuildを反転させたもの)を末尾から取り出すと元の追加順になる

execute unless data storage test: registry_work.reverse_dst[-1] run return 0

data modify storage test: registry_work.name_id set from storage test: registry_work.reverse_dst[-1]
data remove storage test: registry_work.reverse_dst[-1]

function test:magic/build_name_entry with storage test: registry_work

function test:magic/build_name_loop
