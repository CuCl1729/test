#> test:magic/aoe/revive
# 範囲の魔法の中心(実行位置)から radius 以内でダウンしているプレイヤーを、HP percent% で起こす(test:status/revive)。
# @macro radius/percent: 範囲の半径(ブロック)と、戻すHP(最大HPの何%)

$execute as @a[tag=downed,distance=..$(radius)] run function test:status/revive {percent:$(percent)}
