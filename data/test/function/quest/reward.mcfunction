#> test:quest/reward
# @s = 報酬を受け取るプレイヤー。@macro id: クエスト。報酬の処理(asset.quest.<id>.reward。生成された処理の関数)を行う

function #oh_my_dat:please
$execute if data storage test: asset.quest.$(id).reward at @s run function test:quest/reward_run with storage test: asset.quest.$(id)
