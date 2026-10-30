#> test:machine/input/take
# @s = 機械のマーカー。@macro l/u/f: 原石の入れ物の位置。最初のスロットから1個取り出し、
# 処理が終わるまでマーカーのデータ(data.machine.processing)に持っておく

$execute positioned ^$(l) ^$(u) ^$(f) run function test:machine/input/take_here
