#> test:npc/cart/act/page_prev
# @s = [前のページ] を取ったプレイヤー。@macro cart: トロッコの持ち主の番号。前の14個を出す(描き直しは呼び出し元)

$execute as @e[type=chest_minecart,tag=npc_cart] if score @s test.npc.cart_owner matches $(cart) run scoreboard players remove @s test.npc.cart_page 1
