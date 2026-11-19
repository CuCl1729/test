#> test:magic/field/leave_remove
# @s = 場から出た相手。field_work.leave.buff に覚えてあるぶん(= この場が掛けたぶん)だけ外す。
# 毒のような不利な効果もここで一緒に終わる。既に受けたダメージ・回復は取り消さない
data modify storage test: field_work.rm set value []
data modify storage test: field_work.rm set from storage test: field_work.leave.buff
function test:magic/field/leave_remove_loop
