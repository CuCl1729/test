#> test:debug/mine_status
# @s = プレイヤー。全部の鉱山について、マップごとに「中に人がいるか」と「次にリセットできるまでの秒数」を出す

execute store result score #mine_now test.temporary run time query gametime
data modify storage test: mine_work.debug_queue set from storage test: asset.mine_ids
function test:debug/mine_status_loop
