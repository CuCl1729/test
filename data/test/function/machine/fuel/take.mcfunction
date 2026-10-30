#> test:machine/fuel/take
# @s = 機械のマーカー。@macro l/u/f: 燃料の入れ物の位置。燃料を1個取り出し、その回数(asset.fuel."<id>".count)を
# 残りの燃料(test.machine.fuel)に足す。燃料でないものは machine/fuel/clean で出してあるので、最初のスロットを使う

$execute positioned ^$(l) ^$(u) ^$(f) if data block ~ ~ ~ Items[0] run function test:machine/fuel/take_here
