#> test:job/station/populate_tree_loop
# @s = Jobステーション本体。@macro id: 表示対象の職業id。registry_work.tree_queueを末尾から詰める
# (現状は7件までを想定しページングは未実装)

execute unless data storage test: registry_work.tree_queue[-1] run return 0
execute if score #tree_slot test.temporary matches 7.. run return 0

data modify storage test: registry_work.tree_entry set from storage test: registry_work.tree_queue[-1]
data remove storage test: registry_work.tree_queue[-1]

$data modify storage test: registry_work.tree_entry.job set value "$(id)"
execute store result storage test: registry_work.tree_entry.slot int 1 run scoreboard players get #tree_slot test.temporary
function test:job/station/populate_tree_slot with storage test: registry_work.tree_entry

scoreboard players add #tree_slot test.temporary 1
$function test:job/station/populate_tree_loop {id:"$(id)"}
