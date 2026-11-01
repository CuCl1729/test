#> test:debug/quest_op_reset
# @s = プレイヤー。@macro id: クエストを未受注に戻す(メインは全員共通の状態を消す)

$execute if data storage test: asset.quest.$(id){main:1b} run return run data remove storage test: story.quest.$(id)
$data remove storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.quest.$(id)
