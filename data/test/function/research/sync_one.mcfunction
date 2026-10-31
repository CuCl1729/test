#> test:research/sync_one
# @s = プレイヤー。@macro id: 研究のid。済でなく、解放のどれかがもう記録されていれば、済にして残りも解放する

$execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.research.done.$(id) run return 0
scoreboard players set #rs_known test.temporary 0
$data modify storage test: research_work.sq set from storage test: asset.research.$(id).unlock
function test:research/sync_check_loop
$execute if score #rs_known test.temporary matches 1 run function test:research/grant {id:"$(id)"}
