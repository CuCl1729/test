#> test:debug/give_pickaxes
# @s = プレイヤー。ツルハシを全種類(asset.pickaxe_ids)1本ずつ、インベントリに直接渡す

data modify storage test: debug_work.give_queue set value []
data modify storage test: debug_work.give_queue set from storage test: asset.pickaxe_ids
function test:debug/give_pickaxes_loop
