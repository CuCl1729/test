#> test:magic/field/leave_remove_loop
# @s = 場から出た相手。この場が掛けたバフを1件ずつ、「この場の名前のぶんだけ」外す。
# 毒のような不利な効果もここで一緒に終わる。既に受けたダメージ・回復は取り消さない。
# ほかの魔法が独立に掛けた同じidの効果は、バフ側が持ち主を分けて持っているので残る
execute unless data storage test: field_work.rm[0] run return 0

data modify storage test: field_work.rm_one set from storage test: field_work.rm[0]
data remove storage test: field_work.rm[0]

data remove storage test: buff_work.src_arg
data modify storage test: buff_work.src_arg.id set from storage test: field_work.rm_one.id
data modify storage test: buff_work.src_arg.key set value "f0"
function test:magic/field/src_key with storage test: field_work
function test:buff/remove_source with storage test: buff_work.src_arg

function test:magic/field/leave_remove_loop
