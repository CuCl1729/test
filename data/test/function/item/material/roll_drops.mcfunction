#> test:item/material/roll_drops
# @s = 倒された敵。data.material_drops({id,min,max}の一覧。1件が1回の抽選)の個数を rng/roll で決め、
# 1個以上のものを storage test: battle.temporary.material_hits に {id,count} で足す(test:battle/grant_reward が空にしてから呼ぶ)

data modify storage test: item_work.material_drop_queue set value []
data modify storage test: item_work.material_drop_queue set from entity @s data.material_drops
function test:item/material/roll_drops_loop
