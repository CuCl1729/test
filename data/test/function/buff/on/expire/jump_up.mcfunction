#> test:buff/on/expire/jump_up
# @s = バフ保持者。自分のジャンプ強度修飾子を外すだけ(量は見なくてよい。applyが入れ直す形のため)

# 新形式の正本があるときは、残った段ぶんを残して入れ直す(全部外してしまわないため)
execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.buff_state{version:2} run return run function test:buff/native/reconcile

data modify storage test: buff_work.attr_arg set value {attribute:"minecraft:jump_strength",modifier:"test:jump_up"}
function test:buff/attribute/remove with storage test: buff_work.attr_arg
