#> test:npc/cart/shop/sell_run
# @s = 店のトロッコ(実行位置も @s)。@macro npc: 店員。その店の売りの関数で売る枠を売り、残ったものを売る人(tag=npc_cart_clicker)に返す

$function test:npc/cart/shop/sell_shop with storage test: asset.npc.$(npc)
function test:npc/cart/give_slot {slot:14}
function test:npc/cart/give_slot {slot:15}
function test:npc/cart/give_slot {slot:16}
function test:npc/cart/give_slot {slot:17}
