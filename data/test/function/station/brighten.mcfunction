#> test:station/brighten
# @s = ステーションのマーカー。頭上の名前と目印(乗っている text_display / item_display)の明るさを固定する。
# 表示エンティティの明るさは自分の位置(樽の中)で決まるので、固定しないと真っ暗に描かれる。
# test:station/decorate は最初から固定して出すので、これはそれより前に付けた飾りのため(一度だけ。tag=station_bright)

execute on passengers if entity @s[tag=station_label] run data modify entity @s brightness set value {sky:15,block:15}
tag @s add station_bright
