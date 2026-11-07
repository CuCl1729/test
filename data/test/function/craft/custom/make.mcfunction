# @s = 取得者、実行位置 = 台。消費前に現在の材料と本人の研究を確認する。
function #oh_my_dat:please
function test:craft/custom/eval
$execute unless data storage test: craft_work.match{recipe:"$(recipe)"} run return run tellraw @s {text:"材料が足りない",color:"red"}
execute if score #cc_ok test.temporary matches 0 run return run tellraw @s {text:"材料が足りない",color:"red"}
function test:craft/custom/unlocked with storage test: craft_work.match
execute if score #cc_ok test.temporary matches 2 run return run tellraw @s {text:"未研究",color:"red"}
data remove storage test: loot.item
function test:craft/custom/build_result with storage test: craft_work.rec.out
execute unless data storage test: loot.item.id run return 0
function test:craft/custom/deliver with storage test: station_action
