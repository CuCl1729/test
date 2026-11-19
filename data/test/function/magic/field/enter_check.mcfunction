#> test:magic/field/enter_check
# @s = 場の中に居る者。@macro e: その者の通し番号。
# 初めて入ったのなら掛けて「この場が実際に増やせた段数」を覚える。
# 既に掛けてある相手なら段数は足さず、切れていたものだけ掛け直す(test:magic/field/stay_check)。
# 毎パルス素直に掛け直すと、重ねがけのバフが毎秒増えてしまうため
$execute if data storage test: field_work.members[{e:$(e)}] run return run function test:magic/field/stay_check with storage test: field_work.one
execute unless data storage test: field_work.pending[0] run return 0

data modify storage test: field_work.granted set value []
data modify storage test: field_work.apply_queue set from storage test: field_work.pending
function test:magic/field/apply_loop

# 1段も増やせなかった(全部ほかの魔法のぶんで上限に達していた等)なら、覚えることは何も無い
execute unless data storage test: field_work.granted[0] run return 0

$data modify storage test: field_work.keep append value {e:$(e),buff:[]}
data modify storage test: field_work.keep[-1].buff set from storage test: field_work.granted
execute if entity @s[type=player] run data modify storage test: field_work.keep[-1].player set value 1b
