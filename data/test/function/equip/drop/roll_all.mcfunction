#> test:equip/drop/roll_all
# @s = 倒された敵。data.equip_drops({id,chance}の一覧)を1件ずつ抽選し、落ちた装備のidを
# storage test: battle.temporary.equip_hits に {id} で足す(test:battle/grant_reward が空にしてから呼ぶ)。
# 落ちるかどうかだけを敵1体につき1回決める。中身(レア度など)は受け取る人ごとに test:equip/drop/give が決める

data modify storage test: equip_work.drop_queue set value []
data modify storage test: equip_work.drop_queue set from entity @s data.equip_drops
function test:equip/drop/loop
