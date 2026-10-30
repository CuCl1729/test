#> test:machine/place
# @s = エッグで置かれた機械のマーカー(実行位置も@s)。機械は 3×3×3 で、エッグを使った床の上の位置が一番下の段の真ん中になる。
# マーカーをその1つ上(核の位置)の中心に移し、核の2つ下が床(#test:machine_floor)で核の位置が空いていれば核を置く。
# 置けなければエッグを返して消える

tag @s remove summoned
execute align xyz run tp @s ~0.5 ~1.5 ~0.5 0 0

execute at @s unless block ~ ~-2 ~ #test:machine_floor run return run function test:machine/place_fail with entity @s data.machine
execute at @s unless block ~ ~ ~ #minecraft:air run return run function test:machine/place_fail with entity @s data.machine
function test:machine/place_core with entity @s data.machine
