#> test:npc/cart/return_items
# @s = トロッコ(実行位置も @s)。UIのアイテム以外(プレイヤーが置いたもの)を、tag=npc_cart_owner の人の足元に落とす(いなければその場)。
# 中身は全部消す(UIは描き直すか、トロッコごと消える)

data modify storage test: cart_work.items set from entity @s Items
data remove storage test: cart_work.items[{components:{"minecraft:custom_data":{test:{shop_ui:{}}}}}]
data remove entity @s Items
function test:npc/cart/return_loop
