#> test:magic/crafter/populate_build_loop
# registry_work.build_render_queue を先頭[0]から取り出す(追加順どおりに左詰めで表示するため。
# 最大9件なのでレジストリ走査のような[-1]反転は行わずそのまま先頭から処理する)

execute unless data storage test: registry_work.build_render_queue[0] run return 0

data modify storage test: registry_work.build_render_entry set value {id:""}
data modify storage test: registry_work.build_render_entry.id set from storage test: registry_work.build_render_queue[0]
data remove storage test: registry_work.build_render_queue[0]
execute store result storage test: registry_work.build_render_entry.slot int 1 run scoreboard players get #build_slot test.buff.work

function test:magic/crafter/populate_build_slot with storage test: registry_work.build_render_entry

scoreboard players add #build_slot test.buff.work 1

function test:magic/crafter/populate_build_loop
