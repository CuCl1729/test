#> test:machine/place_fail
# @s = 置けなかった機械のマーカー。@macro id: 機械の種類。エッグを返して消える。
# killタグ(tickの最後に消す)ではなくすぐ消す(同じtickの毎秒の確認が、核の無い機械としてもう1個エッグを落とさないように)

$function test:machine/give_egg {id:"$(id)"}
tellraw @p[distance=..8] {text:"機械は工場の中の空いた所に置く",color:"gray"}
kill @s
