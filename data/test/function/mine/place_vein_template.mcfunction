#> test:mine/place_vein_template
# @s = 鉱脈のアマスタ(at @s)。@macro structure: 鉱脈の形の構造物(ほかのキーも渡ってくるが使わない)。
# アマスタの位置を角にして置く。保存するときに鉱石以外をストラクチャーヴォイドにしておけば、通路は上書きしない

$place template $(structure) ~ ~ ~
