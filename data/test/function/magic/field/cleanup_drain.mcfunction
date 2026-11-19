#> test:magic/field/cleanup_drain
# @s = 戻ってきたプレイヤー。@macro e: その人の通し番号。
# test:field_cleanup に積んである自分の持ち分を1件ずつ test:magic/field/leave_remove で外し、
# 処理した分だけ記録を減らす。空になったら自分の欄も消す。ほかの人・ほかの場の分は触らない
$execute unless data storage test: field_cleanup[{e:$(e)}] run return 0

$execute unless data storage test: field_cleanup[{e:$(e)}].pending[0] run return run data remove storage test: field_cleanup[{e:$(e)}]

$data modify storage test: field_work.fid set from storage test: field_cleanup[{e:$(e)}].pending[0].fid
$data modify storage test: field_work.leave.buff set from storage test: field_cleanup[{e:$(e)}].pending[0].buff
function test:magic/field/leave_remove

$data remove storage test: field_cleanup[{e:$(e)}].pending[0]
$execute if data storage test: field_cleanup[{e:$(e)}].pending[0] run function test:magic/field/cleanup_drain {e:$(e)}
$execute unless data storage test: field_cleanup[{e:$(e)}].pending[0] run data remove storage test: field_cleanup[{e:$(e)}]
