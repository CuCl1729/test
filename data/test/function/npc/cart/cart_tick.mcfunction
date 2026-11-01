#> test:npc/cart/cart_tick
# @s = 店・銀行のトロッコ(test:tick から毎tick。実行位置も @s)。下のホッパーを取り除く。持ち主がいない・遠い・店員から離れたら片付ける。
# 銀行なら、預ける枠に置かれたコインを口座に入れる

execute if block ~ ~-1 ~ minecraft:hopper run setblock ~ ~-1 ~ air destroy
scoreboard players operation #owner test.temporary = @s test.npc.cart_owner
execute as @a if score @s test.pid = #owner test.temporary run tag @s add npc_cart_owner
execute unless entity @a[tag=npc_cart_owner,distance=..8] run return run function test:npc/cart/cleanup
execute at @a[tag=npc_cart_owner] unless entity @e[type=interaction,tag=npc_counter,distance=..6] run return run function test:npc/cart/cleanup
execute if entity @s[tag=cart_bank] run function test:npc/cart/bank/tick
tag @a remove npc_cart_owner
