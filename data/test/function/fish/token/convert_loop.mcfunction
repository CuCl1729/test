#> test:fish/token/convert_loop
# @s = プレイヤー。fish_work.queue(asset.fish_pool_ids のコピー)を1つずつ変える

execute unless data storage test: fish_work.queue[0] run return 0
data modify storage test: fish_work.arg set value {id:""}
data modify storage test: fish_work.arg.id set from storage test: fish_work.queue[0]
data remove storage test: fish_work.queue[0]
function test:fish/token/convert_one with storage test: fish_work.arg
function test:fish/token/convert_loop
