#> test:research/sync_one
# @s = プレイヤー。@macro id: 研究のid。済でなく、解放するものが1つ以上あって全部もう記録されていれば、済にする

$execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.research.done.$(id) run return 0
$execute unless data storage test: asset.research.$(id).unlock[0] run return 0
scoreboard players set #rs_all test.temporary 1
$data modify storage test: research_work.sq set from storage test: asset.research.$(id).unlock
function test:research/sync_check_loop
$execute if score #rs_all test.temporary matches 1 run data modify storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.research.done.$(id) set value 1b
