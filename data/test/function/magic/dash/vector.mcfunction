#> test:magic/dash/vector
# @s = 一時的な目印(呼び出し元の `execute summon marker run function ...` で直接束縛されたマーカー)。
# @macro distance / yaw。原点へ yaw 向き・pitch0 で立たせ、その場から前方へ distance ブロック進んだ
# 位置を求める(大きな絶対座標のままだと丸め誤差が出るため、原点付近でだけ計算する)。
# 0.01単位への丸めで符号付きのベクトルが互いに打ち消し合うよう、読む前に+0.005だけずらしておく。
# 結果は世界座標のX/Z成分(×100 = 0.01単位)として #dash_dx/#dash_dz test.temporary に残す。
$teleport @s 0.0 0.0 0.0 $(yaw) 0
$execute at @s positioned ^ ^ ^$(distance) run teleport @s ~ ~ ~
execute at @s run teleport @s ~0.005 ~ ~0.005

execute store result score #dash_dx test.temporary run data get entity @s Pos[0] 100
execute store result score #dash_dz test.temporary run data get entity @s Pos[2] 100

kill @s
