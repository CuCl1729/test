#> test:npc/cart/click_read_inv
# @s = プレイヤー。持ち物(Shiftクリックで入った)の UI のアイテムの印を cart_work.ui に入れる

data modify storage test: cart_work.ui set from entity @s Inventory[{components:{"minecraft:custom_data":{test:{shop_ui:{}}}}}].components."minecraft:custom_data".test.shop_ui
