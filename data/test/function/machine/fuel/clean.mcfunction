#> test:machine/fuel/clean
# @s = 機械のマーカー。@macro l/u/f: 燃料の入れ物の位置。燃料(asset.fuel にあるアイテムid)でないものを全部、出すもの(machine_work.drop)に移す

$execute positioned ^$(l) ^$(u) ^$(f) run function test:machine/fuel/clean_here
