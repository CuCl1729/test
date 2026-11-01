#> test:npc/cart/click_read_cursor
# @s = プレイヤー。カーソルの上の UI のアイテム(プレイヤーの NBT には無いので、シュルカーボックスに写して読む)の印を cart_work.ui に入れる

execute in minecraft:overworld run item replace block 0 -64 0 container.0 from entity @s player.cursor
execute in minecraft:overworld run data modify storage test: cart_work.ui set from block 0 -64 0 Items[{Slot:0b}].components."minecraft:custom_data".test.shop_ui
