#> test:npc/cart/remove_mine
# @s = プレイヤー。自分のトロッコを片付ける(置いたものは返す)

execute as @e[type=chest_minecart,tag=npc_cart_mine] at @s run function test:npc/cart/cleanup
data remove storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.cart
scoreboard players set @s test.npc.cart_lost 0
