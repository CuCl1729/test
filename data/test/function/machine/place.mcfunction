#> test:machine/place
# @s = エッグで置かれた機械のマーカー(実行位置も@s)。機械は 3×3×3 で、エッグを使った位置が一番下の段の真ん中になる。
# マーカーをその1つ上(核の位置)の中心に移し、工場(test:factory)の中で核の位置が空いていれば核を置く。
# 置けなければエッグを返して消える

tag @s remove summoned
execute align xyz run tp @s ~0.5 ~1.5 ~0.5 0 0

execute at @s unless dimension test:factory run return run function test:machine/place_fail with entity @s data.machine
execute at @s unless block ~ ~ ~ #minecraft:air run return run function test:machine/place_fail with entity @s data.machine
function test:machine/place_core with entity @s data.machine
