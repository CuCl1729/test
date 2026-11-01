#> test:npc/cart/return_loop
# cart_work.items を1件ずつ、持ち主(いなければその場)に落とす

execute unless data storage test: cart_work.items[0] run return 0
data modify storage test: loot.item set from storage test: cart_work.items[0]
data remove storage test: loot.item.Slot
data remove storage test: cart_work.items[0]
execute if entity @a[tag=npc_cart_owner,limit=1] at @a[tag=npc_cart_owner,limit=1] run function test:item/drop_at
execute unless entity @a[tag=npc_cart_owner,limit=1] run function test:item/drop_at
function test:npc/cart/return_loop
