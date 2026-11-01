#> test:npc/cart/follow
# @s = プレイヤー。自分のトロッコを頭の位置に動かす(開いている間は視点が動かないので、そのまま付いてくる)

execute anchored eyes positioned ^ ^-0.35 ^ run tp @e[type=chest_minecart,tag=npc_cart_mine] ~ ~ ~
