#> test:npc/cart/lost
# @s = プレイヤー。目線が店員・銀行員から外れている。少し揺れただけで消えないよう、10tick続いたら片付ける(それまでは付いてくる)

scoreboard players add @s test.npc.cart_lost 1
execute if score @s test.npc.cart_lost matches 10.. run return run function test:npc/cart/remove_mine
function test:npc/cart/follow
