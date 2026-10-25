#> test:equip/drop/roll_all
# @s = 報酬を受け取るプレイヤー。storage test: battle.temporary.equip_drops({id,chance}の一覧)を1件ずつ抽選し、
# 当たった装備を作って渡す

data modify storage test: equip_work.drop_queue set value []
data modify storage test: equip_work.drop_queue set from storage test: battle.temporary.equip_drops
function test:equip/drop/loop
