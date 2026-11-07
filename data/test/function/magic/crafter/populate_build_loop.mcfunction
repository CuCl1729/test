#> test:magic/crafter/populate_build_loop
# @s = クラフター本体。registry_work.build_render_queue を先頭[0]から取り出し、追加順どおりに中段(スロット9〜17)へ
# 左詰めで出す。中段は9件まで(続きは次のページ)。出した id は data.crafter_ui.view に積む
execute unless data storage test: registry_work.build_render_queue[0] run return 0
execute if score #build_slot test.buff.work matches 18.. run return 0
data modify storage test: registry_work.build_render_entry set value {id:""}
data modify storage test: registry_work.build_render_entry.id set from storage test: registry_work.build_render_queue[0]
data remove storage test: registry_work.build_render_queue[0]
data modify entity @s data.crafter_ui.view append from storage test: registry_work.build_render_entry.id
execute store result storage test: registry_work.build_render_entry.slot int 1 run scoreboard players get #build_slot test.buff.work
function test:magic/crafter/populate_build_slot with storage test: registry_work.build_render_entry
scoreboard players add #build_slot test.buff.work 1
function test:magic/crafter/populate_build_loop
