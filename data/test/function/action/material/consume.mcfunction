#> test:action/material/consume
# 実行位置 = 鍛冶場マーカー。forge_work.specials に集めた特殊素材を樽から取り除く。
# レシピが成立した後にのみ呼ぶこと(成立判定はここでは行わない)

data modify storage test: material_work.queue set value []
data modify storage test: material_work.queue set from storage test: forge_work.specials
function test:action/material/consume_loop

data remove storage test: forge_work.specials
