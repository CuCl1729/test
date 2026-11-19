#> test:magic/dispatch
# @s = 詠唱者。プレイヤーが直接唱えた段が「何になるか」を、組み合わせの表で決めて呼ぶ
# (タイプを増やしてもここは触らない。表に行を足すだけで済む)
data remove storage test: combo_work.flags
data modify storage test: combo_work.flags set from storage test: magic.player.type_flags
data modify storage test: combo_work.apply set value "stage"
data modify storage test: combo_work.emitter set value "player"
function test:magic/combo/match

execute if score #combo_found test.temporary matches 0 run return run function test:magic/combo/reject
function test:magic/combo/run
