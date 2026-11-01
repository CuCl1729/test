#> test:npc/cart/act/buy
# @s = 品物の見本を取ったプレイヤー(買う人。トロッコの持ち主でなくてもよい)。@macro npc/i: 店員と、店の品物の番号

data modify storage test: cart_work.b set value {shop:"",i:0}
$data modify storage test: cart_work.b.shop set from storage test: asset.npc.$(npc).shop
$data modify storage test: cart_work.b.i set value $(i)
function test:npc/cart/shop/buy_load with storage test: cart_work.b
