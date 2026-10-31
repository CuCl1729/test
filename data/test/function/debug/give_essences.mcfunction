#> test:debug/give_essences
# @s = プレイヤー。魔法作物のエッセンスを全種類16個ずつ渡す

data modify storage test: debug_work.give_queue set from storage test: asset.magic_crop_ids
function test:debug/give_essences_loop
