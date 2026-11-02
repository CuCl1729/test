#> test:gather/egg/remove
# @s = 消す採取ポイント(interaction)。@macro point: ポイントのid(ほかのキーも渡ってくるが使わない)。
# 記録と復活待ちの状態から消し、このマップのエンティティを片付ける。もう片方のマップのものは、
# 読み込まれたときに test:gather/place/check が片付ける(記録に無いため)
$data remove storage test: gather_world.point.$(point)
$data remove storage test: gather_world.ids[{id:"$(point)"}]
$data remove storage test: gather_state.action.$(point)
$data remove storage test: gather_state.turn.$(point)
function test:gather/place/remove
