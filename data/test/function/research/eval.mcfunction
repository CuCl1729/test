#> test:research/eval
# @s = プレイヤー(oh_my_dat は @s を指している)。@macro id: 研究のid。条件を調べ、GUIに置くアイテムを research_work.item に作る。
#   #rs_done = 済なら1、#rs_ok = 条件を全部満たしていれば1、research_work.missing = 最初に足りなかったもの(短い文)。
#   説明文は コスト・前提・観測・知識 の順に1行ずつ(満たしていれば緑、足りなければ赤)。済なら条件は出さない

$data modify storage test: research_work.def set from storage test: asset.research.$(id)
data modify storage test: research_work.lore set value []
data modify storage test: research_work.missing set value ""
scoreboard players set #rs_ok test.temporary 1
scoreboard players set #rs_done test.temporary 0
$execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.research.done.$(id) run scoreboard players set #rs_done test.temporary 1

execute if score #rs_done test.temporary matches 0 run function test:research/eval_cost with storage test: research_work.def
execute if score #rs_done test.temporary matches 0 run data modify storage test: research_work.q set from storage test: research_work.def.pre
execute if score #rs_done test.temporary matches 0 run function test:research/eval_pre_loop
execute if score #rs_done test.temporary matches 0 run data modify storage test: research_work.q set from storage test: research_work.def.scans
execute if score #rs_done test.temporary matches 0 run function test:research/eval_scan_loop
execute if score #rs_done test.temporary matches 0 run data modify storage test: research_work.kq set from storage test: research_work.def.knowledge
execute if score #rs_done test.temporary matches 0 run function test:research/eval_know_loop

function test:research/eval_item with storage test: research_work.def
