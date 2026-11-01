#> test:npc/cart/shop/buy_load
# @s = 買う人。@macro shop/i: 店と品物の番号。その品物の定義で買う

$data modify storage test: cart_work.e set from storage test: asset.shop.$(shop).items[$(i)]
function test:npc/cart/shop/buy_do with storage test: cart_work.e
