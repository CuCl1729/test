#> test:craft/custom/reclaim_drop
# 実行位置 = 樽。tag=cc_reclaim の落ちているアイテムから、#cc_left 個になるまで消す(近いものから。多い分は数を減らす)

execute unless score #cc_left test.temporary matches 1.. run return 0
execute unless entity @e[type=item,tag=cc_reclaim,limit=1] run return 0
execute as @n[type=item,tag=cc_reclaim] run function test:craft/custom/reclaim_drop_one
function test:craft/custom/reclaim_drop
