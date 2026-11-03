#> test:magic/crafter/stage_requires_loop
# registry_work.requires_queue(今の段の要素id)を1つずつ見て、requires_type のある効果なら、そのタイプが段の中にあるかを確かめる
execute unless data storage test: registry_work.requires_queue[0] run return 0
data modify storage test: registry_work.requires_arg set value {id:""}
data modify storage test: registry_work.requires_arg.id set from storage test: registry_work.requires_queue[0]
data remove storage test: registry_work.requires_queue[0]
function test:magic/crafter/stage_requires with storage test: registry_work.requires_arg
function test:magic/crafter/stage_requires_loop
