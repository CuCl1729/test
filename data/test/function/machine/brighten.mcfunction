#> test:machine/brighten
# @s = 機械のマーカー。頭上の表示(乗っている text_display)の明るさを固定する。
# 表示エンティティの明るさは自分の位置(核のブロックの中)で決まるので、固定しないと真っ暗に描かれる。
# test:machine/place_core は最初から固定して出すので、これはそれより前に置いた機械のため(一度だけ。tag=machine_bright)

execute on passengers if entity @s[tag=machine_label] run data modify entity @s brightness set value {sky:15,block:15}
tag @s add machine_bright
