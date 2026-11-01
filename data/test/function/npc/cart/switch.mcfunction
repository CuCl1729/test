#> test:npc/cart/switch
# @s = プレイヤー。自分のトロッコ(tag=npc_cart_mine)を、目線の先の NPC(cart_work.hit.npc)の店・銀行に入れ替える。
# 前の画面の売る枠・預ける枠に置いたものは、先に持ち主(@s)に返す

data modify storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.cart.npc set from storage test: cart_work.hit.npc
tag @s add npc_cart_owner
execute as @e[type=chest_minecart,tag=npc_cart_mine] at @s run function test:npc/cart/return_items
tag @s remove npc_cart_owner
execute as @e[type=chest_minecart,tag=npc_cart_mine] at @s run function test:npc/cart/populate with storage test: cart_work.hit
