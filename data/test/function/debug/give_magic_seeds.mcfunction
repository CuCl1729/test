#> test:debug/give_magic_seeds
# @s = プレイヤー。魔法作物の種を全種類(asset.magic_crop_ids)16個ずつ渡す

data modify storage test: debug_work.give_queue set from storage test: asset.magic_crop_ids
function test:debug/give_magic_seeds_loop
