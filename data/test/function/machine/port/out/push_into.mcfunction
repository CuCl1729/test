#> test:machine/port/out/push_into
# @s = 機械のマーカー。@macro tx/ty/tz: 送り先の、核からのずれ(ほかのキーも渡ってくるが使わない)

$execute at @s positioned ~$(tx) ~$(ty) ~$(tz) run function test:machine/port/out/push_insert_loop
