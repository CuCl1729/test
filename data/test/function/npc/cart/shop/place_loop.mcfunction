#> test:npc/cart/shop/place_loop
# @s = 店のトロッコ。cart_work.sq の先頭から、スロット #slot(0〜13)に品物の見本を置く。#si = 品物の番号(店の items の何番目か)

execute if score #slot test.temporary matches 14.. run return 0
execute unless data storage test: cart_work.sq[0] run return 0
data modify storage test: cart_work.se set from storage test: cart_work.sq[0]
data remove storage test: cart_work.sq[0]
execute store result storage test: cart_work.se.slot int 1 run scoreboard players get #slot test.temporary
execute store result storage test: cart_work.se.i int 1 run scoreboard players get #si test.temporary
data modify storage test: cart_work.se.pid set from storage test: cart_work.pop.pid
data modify storage test: cart_work.se.npc set from storage test: cart_work.pop.npc
function test:npc/cart/shop/display with storage test: cart_work.se
scoreboard players add #slot test.temporary 1
scoreboard players add #si test.temporary 1
function test:npc/cart/shop/place_loop
