#> test:npc/cart/summon
# @s = プレイヤー。頭の位置(戦闘のトロッコと同じ ^ ^-0.35 ^)にチェスト付きトロッコを出し、持ち主の番号を記録する。
# 中身は、次の test:npc/cart/switch が入れる(記録の NPC を消して、必ず入れ替えさせる)

execute anchored eyes positioned ^ ^-0.35 ^ run summon chest_minecart ~ ~ ~ {Tags:["npc_cart","npc_cart_new"],NoGravity:1b,Invulnerable:1b,Silent:1b}
scoreboard players operation @e[type=chest_minecart,tag=npc_cart_new] test.npc.cart_owner = @s test.pid
tag @e[type=chest_minecart,tag=npc_cart_new] add npc_cart_mine
tag @e[type=chest_minecart,tag=npc_cart_new] remove npc_cart_new
data remove storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.cart
