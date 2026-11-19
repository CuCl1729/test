#> test:action/material/apply_loop
# 実行位置 = 鍛冶で生成中の武器(loot.item)。material_work.queue を先頭から1件ずつ適用し、
# 無効化(#material_invalid=1)されたか空になったら止まる。発動条件(trigger)は right_click / on_hit の2つだけ

execute if score #material_invalid test.temporary matches 1 run return 0
execute unless data storage test: material_work.queue[0] run return 0

data modify storage test: material_work.entry set from storage test: material_work.queue[0]
data remove storage test: material_work.queue[0]

execute if data storage test: material_work.entry{trigger:"right_click"} run function test:action/material/right_click with storage test: material_work.entry
execute if data storage test: material_work.entry{trigger:"on_hit"} run function test:action/material/on_hit with storage test: material_work.entry

function test:action/material/apply_loop
