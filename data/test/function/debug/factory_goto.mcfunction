#> test:debug/factory_goto
# @s = プレイヤー(クリエイティブ向け)。@macro n: 区画の番号。その区画へ移る(元の場所は記録しない)。
# 区画がまだできていなければ作り始め、もう一度押すよう知らせる

$data modify storage test: factory_work.plot_arg set value {n:$(n)}
function test:factory/plot_area with storage test: factory_work.plot_arg
scoreboard players set #fg_ok test.temporary 0
execute store result score #fg_ok test.temporary run function test:factory/ensure_built with storage test: factory_work.plot
execute if score #fg_ok test.temporary matches 0 run return run tellraw @s {text:"区画を準備中。もう一度押す",color:"gray"}
function test:factory/go_tp with storage test: factory_work.plot
