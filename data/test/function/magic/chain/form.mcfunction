#> test:magic/chain/form
# @s = 持ち主のプレイヤー。実行位置 = この段を始める所。
# つないだ段は「設置物や弾が起こした」段なので、発生元 source として組み合わせの表を引く。
# 同じ要素でも、プレイヤーが直接唱えたとき(投射 → 視線の扇)と、設置物が起こしたとき
# (投射 → 水平の放射。持ち主の位置やカメラによらない)で違う行が当たる
data remove storage test: combo_work.flags
data modify storage test: combo_work.flags set from storage test: magic.player.type_flags
data modify storage test: combo_work.apply set value "stage"
data modify storage test: combo_work.emitter set value "source"
function test:magic/combo/match

execute if score #combo_found test.temporary matches 0 run return 0
function test:magic/combo/run
