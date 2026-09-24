#> test:job/station/populate_tree_slot
# @s = Jobステーション本体(please実行済み)。@macro job/id(ノードid)/label/slot 他:
# registry_work.tree_entryとして展開済み(1ノードぶん+job+slot)。解放済み/解放可能/未解放を
# 出し分ける(解放可否判定はtest:job/skill/eligibility_checkを再利用する。既に解放済みなら
# それを優先しeligibility_checkは呼ばない)

data modify entity @s data.job_ui.node_ids append value ""
$data modify entity @s data.job_ui.node_ids[-1] set value "$(id)"

$execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.data.$(job).skills{$(id):1b} run scoreboard players set #node_state test.temporary 2

$execute unless data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.data.$(job).skills{$(id):1b} run data modify storage test: job_work.skill_entry set from storage test: registry_work.tree_entry
$execute unless data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.data.$(job).skills{$(id):1b} run function test:job/skill/eligibility_check with storage test: job_work.skill_entry
$execute unless data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.data.$(job).skills{$(id):1b} run scoreboard players operation #node_state test.temporary = #job_skill_ok test.job.work

data modify storage test: job_work.tree_item set value {id:"paper",count:1,components:{"minecraft:custom_name":{text:"",italic:false},"minecraft:custom_data":{test:{job_ui:1b}}}}
$data modify storage test: job_work.tree_item.components."minecraft:custom_name".text set value "$(label)"
$data modify storage test: job_work.tree_item.Slot set value $(slot)b

execute if score #node_state test.temporary matches 2 run data modify storage test: job_work.tree_item.components."minecraft:custom_name".color set value "green"
execute if score #node_state test.temporary matches 2 run data modify storage test: job_work.tree_item.id set value "nether_star"
execute if score #node_state test.temporary matches 1 run data modify storage test: job_work.tree_item.components."minecraft:custom_name".color set value "yellow"
execute if score #node_state test.temporary matches 0 run data modify storage test: job_work.tree_item.components."minecraft:custom_name".color set value "gray"

data modify block ~ ~ ~ Items append from storage test: job_work.tree_item
