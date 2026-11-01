#> test:npc/cart/cleanup
# @s = 片付けるトロッコ(実行位置も @s)。売る枠・預ける枠に置かれたままのものを持ち主に返して(いなければその場に落として)消える

scoreboard players operation #owner test.temporary = @s test.npc.cart_owner
execute as @a if score @s test.pid = #owner test.temporary run tag @s add npc_cart_owner
function test:npc/cart/return_items
tag @a remove npc_cart_owner
kill @s
