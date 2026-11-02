#> test:debug/give_gather_eggs
# @s = プレイヤー。採取ポイントのエッグを、採取物の全種類(asset.gather_ids)ぶん渡す
data modify storage test: debug_work.give_queue set from storage test: asset.gather_ids
function test:debug/give_gather_eggs_loop
