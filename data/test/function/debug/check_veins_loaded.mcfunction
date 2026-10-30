#> test:debug/check_veins_loaded
# @macro x1/y1/z1/x2/z2: 鉱山の範囲の角。両方のマップで範囲の両端の角が読み込まれていれば 1、そうでなければ 0 を返す

$execute in test:action unless loaded $(x1) $(y1) $(z1) run return 0
$execute in test:action unless loaded $(x2) $(y1) $(z2) run return 0
$execute in test:turn unless loaded $(x1) $(y1) $(z1) run return 0
$execute in test:turn unless loaded $(x2) $(y1) $(z2) run return 0
return 1
