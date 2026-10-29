#> test:item/material/give_hits
# @s = 報酬を受け取るプレイヤー。battle.temporary.material_hits({id,count}の一覧)を1件ずつ渡す(test:item/material/give)

data modify storage test: item_work.material_give_queue set value []
data modify storage test: item_work.material_give_queue set from storage test: battle.temporary.material_hits
function test:item/material/give_hits_loop
