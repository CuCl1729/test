#> test:machine/input/clean
# @s = 機械のマーカー。@macro l/u/f: 原石の入れ物の位置。この機械が受け付けないもの(原石でないもの・段階の合わない原石・
# まだ原石に変わっていない目印など)を全部、出すもの(machine_work.drop)に移す

$execute positioned ^$(l) ^$(u) ^$(f) run function test:machine/input/clean_here
