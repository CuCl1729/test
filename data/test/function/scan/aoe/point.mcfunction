#> test:scan/aoe/point
# @macro x/z: サンプル点をプレイヤーの向きから見たローカル座標で表したもの(r·sinθ / r·cosθ)。
# ^x ^ ^zは視線方向と左右方向で張る平面上にあるので、上下の傾きも含めた扇の上の点になる

$execute positioned ^$(x) ^ ^$(z) run function test:scan/aoe/probe
$particle end_rod ^$(x) ^ ^$(z) 0 0 0 0 0
