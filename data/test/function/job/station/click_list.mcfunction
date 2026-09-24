#> test:job/station/click_list
# @s = Jobステーション本体。@macro index: 取られたスロットのpage_ids内インデックス(0〜6)
# 前提を満たしていれば解放してから、その職業のツリービューへ切り替える

data modify storage test: registry_work.click set value {id:""}
$data modify storage test: registry_work.click.id set from entity @s data.job_ui.page_ids[$(index)]

execute as @p[distance=..3] run function test:job/station/click_list_try_unlock with storage test: registry_work.click

data modify entity @s data.job_ui.job set from storage test: registry_work.click.id
data modify entity @s data.job_ui.view set value "tree"

function test:job/station/populate_tree
