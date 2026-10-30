#> test:machine/port/out/place_into
# @s = 機械のマーカー。@macro x/y/z: 搬出口の、核からのずれ(ほかのキーも渡ってくるが使わない)。
# machine_work.stack を、入らなくなるまで1個ずつ、その搬出口の中に入れる

$execute at @s positioned ~$(x) ~$(y) ~$(z) run function test:machine/port/out/place_loop
