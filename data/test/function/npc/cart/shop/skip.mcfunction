#> test:npc/cart/shop/skip
# cart_work.sq(店の品物の写し)の先頭から #skip 件を捨てる(前のページの分)。#si は捨てた数(品物の番号の始まり)

execute unless score #skip test.temporary matches 1.. run return 0
execute unless data storage test: cart_work.sq[0] run return 0
data remove storage test: cart_work.sq[0]
scoreboard players remove #skip test.temporary 1
scoreboard players add #si test.temporary 1
function test:npc/cart/shop/skip
