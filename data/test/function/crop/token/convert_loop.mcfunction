#> test:crop/token/convert_loop
# @s = プレイヤー。crop_work.queue(asset.crop_ids のコピー)を1つずつ変える

execute unless data storage test: crop_work.queue[0] run return 0
data modify storage test: crop_work.arg set value {id:""}
data modify storage test: crop_work.arg.id set from storage test: crop_work.queue[0]
data remove storage test: crop_work.queue[0]
function test:crop/token/convert_one with storage test: crop_work.arg
function test:crop/token/convert_loop
