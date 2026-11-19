#> test:magic/dash/land
# @s = 持ち主。@macro x/y/z = 代理の着地位置(test:magic/dash/tick が、マクロはNBTパスの値しか
# 渡せないため先にstorageへコピーしたもの)。向きは ~ ~ にして、代理のyaw0でカメラを変えない。
$execute positioned 0.0 0.0 0.0 run teleport @s ~$(x) ~$(y) ~$(z) ~ ~
