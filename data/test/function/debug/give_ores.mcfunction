#> test:debug/give_ores
# @s = プレイヤー。原石を全種類(asset.ore_ids)・レア度1〜5、10個ずつインベントリに直接渡す

data modify storage test: debug_work.give_queue set value []
data modify storage test: debug_work.give_queue set from storage test: asset.ore_ids
function test:debug/give_ores_loop
