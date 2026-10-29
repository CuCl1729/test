#> test:equip/drop/give_all
# @s = 報酬を受け取るプレイヤー。battle.temporary.equip_hits({id}の一覧。落ちた装備)を1件ずつ作って渡す(test:equip/drop/give)

data modify storage test: equip_work.give_queue set value []
data modify storage test: equip_work.give_queue set from storage test: battle.temporary.equip_hits
function test:equip/drop/give_loop
