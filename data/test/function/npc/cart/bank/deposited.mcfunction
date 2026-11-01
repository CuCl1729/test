#> test:npc/cart/bank/deposited
# @s = 銀行のトロッコ。預ける枠のコイン #bd G を、持ち主(tag=npc_cart_owner)の口座に入れ、所持金の表示を書き直す

execute store result storage test: money_work.n int 1 run scoreboard players get #bd test.temporary
execute as @a[tag=npc_cart_owner,limit=1] run function test:money/add with storage test: money_work
data modify storage test: cart_work.pop set value {pid:0,npc:""}
execute store result storage test: cart_work.pop.pid int 1 run scoreboard players get @s test.npc.cart_owner
data modify storage test: cart_work.pop.npc set from entity @s Items[{Slot:18b}].components."minecraft:custom_data".test.shop_ui.npc
function test:npc/cart/info
