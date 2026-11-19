#> test:magic/combo/reject
# @s = 詠唱者。組み合わせの表に当たる行が無かった(= 未定義の組み合わせ)。
# 黙って既定動作に落ちないよう、理由を出して終わる。クラフト時に同じ表で弾いているので、本来ここには来ない
execute store success score @s test.ui.bar_shown run title @s actionbar {text:"この組み合わせは使えない",color:"gray"}
