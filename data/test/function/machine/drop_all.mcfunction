#> test:machine/drop_all
# @s = 機械のマーカー。@macro l/u/f: 出口の位置。出すもの(machine_work.drop)を全部、出口にアイテムとして落とす

$execute positioned ^$(l) ^$(u) ^$(f) run function test:machine/drop_loop
