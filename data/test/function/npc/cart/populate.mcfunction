#> test:npc/cart/populate
# @s = トロッコ(実行位置も @s)。@macro npc: 店員・銀行員の NPC id。UIのアイテムを消して、その NPC の役割(asset.npc.<id>.role)の画面を描き、
# 空いているスロットを薄灰色の板ガラスで埋める(役割ごとの画面が、プレイヤーが物を置くスロットを cart_work.keep に入れる)

data remove entity @s Items[{components:{"minecraft:custom_data":{test:{shop_ui:{}}}}}]
$data modify storage test: cart_work.pop set value {npc:"$(npc)",pid:0,role:"",shop:""}
execute store result storage test: cart_work.pop.pid int 1 run scoreboard players get @s test.npc.cart_owner
$data modify storage test: cart_work.pop.role set from storage test: asset.npc.$(npc).role
$data modify storage test: cart_work.pop.shop set from storage test: asset.npc.$(npc).shop
data modify storage test: cart_work.keep set value {}
tag @s remove cart_shop
tag @s remove cart_bank
function test:npc/cart/populate_role with storage test: cart_work.pop
function test:npc/cart/fill with storage test: cart_work.pop
