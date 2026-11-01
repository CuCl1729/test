#> test:npc/cart/act/page_next
# @s = [次のページ] を取ったプレイヤー。@macro cart: トロッコの持ち主の番号。次の14個を出す(描き直しは呼び出し元)

$execute as @e[type=chest_minecart,tag=npc_cart] if score @s test.npc.cart_owner matches $(cart) run scoreboard players add @s test.npc.cart_page 1
