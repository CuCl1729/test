#> test:battle/ui/active_skill_resolve_loop
# registry_work.active_resolve_queueを先頭[0]から数えつつ取り出し、選ばれた番号(#target_index)と
# 一致したら発動する(先頭から数える都合上[0]除去を使う。populate_top_skipと同じ考え方で
# 要素数は数十件程度を想定しコストは無視できる)

execute unless data storage test: registry_work.active_resolve_queue[0] run return 0

scoreboard players add #active_resolve_index test.temporary 1

execute if score #active_resolve_index test.temporary = #target_index test.temporary run data modify storage test: registry_work.active_resolve_entry set from storage test: registry_work.active_resolve_queue[0]
execute if score #active_resolve_index test.temporary = #target_index test.temporary run return run function test:battle/ui/active_skill_resolve_dispatch with storage test: registry_work.active_resolve_entry

data remove storage test: registry_work.active_resolve_queue[0]
function test:battle/ui/active_skill_resolve_loop
