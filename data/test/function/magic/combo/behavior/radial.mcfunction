#> test:magic/combo/behavior/radial
# @s = 持ち主。実行位置 = 撃つ所(設置物や飛んでいる弾の位置)。
# 水平の基準角を抽選し、弾を 360/本数 度ずつに振り分ける(test:projectile/radial)。
# 持ち主の位置やカメラには一切よらない
data modify storage test: magic.player.device_radial set value 1b
function test:magic/projectile/cast
