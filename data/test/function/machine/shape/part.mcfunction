#> test:machine/shape/part
# @s = 機械のマーカー(実行位置は核の中心、向きは機械の前)。@macro block/l/u/f: 部品のブロックと、核から見た位置(左・上・前)。
# そのブロックが無ければ #machine_missing を増やし、近くに人がいれば(#machine_viewer)そこに置くブロックの形のパーティクルを出す
# (プレイヤーがマルチブロックの形を知る手がかり)

$execute positioned ^$(l) ^$(u) ^$(f) if block ~ ~ ~ $(block) run return 0
scoreboard players add #machine_missing test.temporary 1
$execute if score #machine_viewer test.temporary matches 1 positioned ^$(l) ^$(u) ^$(f) run particle minecraft:block_marker{block_state:{Name:"$(block)"}} ~ ~ ~ 0 0 0 0 1 normal @a[distance=..16]
