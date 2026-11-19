#> test:action/material/collect_loop
# 実行位置 = 鍛冶場マーカー。material_work.queue を先頭から1件ずつ集計し、空になったら止まる

execute unless data storage test: material_work.queue[0] run return 0

data modify storage test: material_work.entry set from storage test: material_work.queue[0]
data remove storage test: material_work.queue[0]
function test:action/material/collect_one with storage test: material_work.entry

function test:action/material/collect_loop
