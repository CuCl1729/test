#> test:npc/cart/info
# @s = 店・銀行のトロッコ。@macro pid/npc: 持ち主の番号と NPC id。スロット18に、持ち主の口座の残高と持っているコインの合計(表示用)を置く

scoreboard players operation #owner test.temporary = @s test.npc.cart_owner
execute as @a if score @s test.pid = #owner test.temporary run tag @s add npc_cart_info
data modify storage test: cart_work.inf set value {bank:0,coins:0,pid:0,npc:""}
data modify storage test: cart_work.inf.pid set from storage test: cart_work.pop.pid
data modify storage test: cart_work.inf.npc set from storage test: cart_work.pop.npc
execute as @a[tag=npc_cart_info,limit=1] store result storage test: cart_work.inf.coins int 1 run function test:money/coins
execute as @a[tag=npc_cart_info,limit=1] store result storage test: cart_work.inf.bank int 1 run scoreboard players get @s test.money
tag @a remove npc_cart_info
function test:npc/cart/info_put with storage test: cart_work.inf
