#> test:magic/beam/fan_one
# @s = 詠唱者。@macro yaw: 視線からの左右のずれ(度)。目の高さから1本引く。
# 線はそれぞれ独立に当たり判定を持つので、同じ敵に複数本が当たればその本数ぶん効く
$execute anchored eyes positioned ^ ^ ^ rotated ~$(yaw) ~ run function test:magic/beam/ray
