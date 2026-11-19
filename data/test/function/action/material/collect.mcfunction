#> test:action/material/collect
# 実行位置 = 鍛冶場マーカー。登録済みの特殊素材効果(asset.action.materials)を樽の中身と照合し、
# 載っていた記述子をそのまま forge_work.specials に集める

data modify storage test: forge_work.specials set value []
data modify storage test: material_work.queue set value []
data modify storage test: material_work.queue set from storage test: asset.action.materials
function test:action/material/collect_loop
