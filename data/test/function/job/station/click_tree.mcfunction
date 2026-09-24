#> test:job/station/click_tree
# @s = Jobステーション本体。@macro index: 取られたスロットのnode_ids内インデックス(0〜6)
# 解放可能ならポイントを消費して解放する(test:job/skill/unlockが解放可否を再検証する)

data modify storage test: registry_work.click_node set value {job:"",node:""}
data modify storage test: registry_work.click_node.job set from entity @s data.job_ui.job
$data modify storage test: registry_work.click_node.node set from entity @s data.job_ui.node_ids[$(index)]

execute as @p[distance=..3] run function test:job/skill/unlock with storage test: registry_work.click_node

function test:job/station/populate_tree
