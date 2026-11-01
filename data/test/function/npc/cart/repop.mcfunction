#> test:npc/cart/repop
# @macro cart/npc: 押されたトロッコの持ち主の番号と NPC id。そのトロッコを描き直す(取られた見本やボタンを元のスロットに戻す)

$execute as @e[type=chest_minecart,tag=npc_cart] if score @s test.npc.cart_owner matches $(cart) at @s run function test:npc/cart/populate {npc:"$(npc)"}
