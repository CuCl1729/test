#> test:debug/give_runes
# @s = プレイヤー。ルーンを全種類(asset.rune_ids)1個ずつ、インベントリに直接渡す

data modify storage test: debug_work.give_queue set value []
data modify storage test: debug_work.give_queue set from storage test: asset.rune_ids
data modify storage test: loot.context set value "inventory"
function test:debug/give_runes_loop
data remove storage test: loot.context
