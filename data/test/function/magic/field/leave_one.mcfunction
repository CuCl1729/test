#> test:magic/field/leave_one
# @macro e: 相手の通し番号(ほかのキーも渡ってくるが使わない)。
# まだ中に居るなら何もしない(keep に移してある)。出たのなら、この場が掛けたぶんだけを外す。
# 相手が(別次元含めて)見つからない場合、プレイヤーならログアウト中として覚えておき、
# 戻ってきたとき(test:magic/field/rejoin)に外す。プレイヤーでない相手(倒された敵)はそのまま忘れる
$execute if data storage test: field_work.inside[{e:$(e)}] run return 0
$execute as @e[scores={test.magic.eid=$(e)}] run function test:magic/field/leave_remove
$execute unless entity @e[scores={test.magic.eid=$(e)}] if data storage test: field_work.leave.player run function test:magic/field/cleanup_queue with storage test: field_work.leave
