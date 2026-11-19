# 追尾: 投射体(と自動ビーム)が敵を狙う修飾子。狙う相手は撃った時に決め、いなくなったら選び直す
#   radius: 相手を探す距離(ブロック)
#   turn:   向きを変える速さ(度/秒)
#   delay_ticks: 発射から向きを変え始めるまでのtick数(プレイヤーの直接投射だけに効く。test:magic/projectile/castが0に直す)
$data modify storage test: magic.loot.status.homing merge value {radius:$(radius),turn:$(turn),delay_ticks:$(delay_ticks)}

data modify storage test: magic.loot.status.type_flags.homing set value 1b
data modify storage test: magic.loot.status.types append value "homing"

$scoreboard players add #cost test.temporary $(cost)
