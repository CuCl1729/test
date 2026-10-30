#> test:machine/port/sort
# @s = 機械のマーカー。@macro x/y/z: 搬入口の、核からのずれ。中身を1スロットずつ見る

$execute positioned ~$(x) ~$(y) ~$(z) run function test:machine/port/sort_here
