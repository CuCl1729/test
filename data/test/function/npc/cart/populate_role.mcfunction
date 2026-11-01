#> test:npc/cart/populate_role
# @s = トロッコ。@macro role/npc/pid/shop: 役割(shop / bank)ごとの画面を描く(test:npc/cart/<役割>/populate)

$function test:npc/cart/$(role)/populate {npc:"$(npc)",pid:$(pid),shop:"$(shop)"}
