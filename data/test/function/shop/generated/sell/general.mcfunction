# 自動生成: tools/datasheet/generate.ps1。直接編集しない(スプレッドシートを直して再生成する)
#> test:shop/generated/sell/general
# 店「general」の売り(@s = 店のトロッコ。売る枠 14〜17 のうち、この店が買い取るものを売る)

execute if items entity @s container.14 *[minecraft:custom_data~{test:{material:{kind:"bone"}}}] run function test:npc/cart/shop/sell_slot {slot:14,count:3,price:5}
execute if items entity @s container.15 *[minecraft:custom_data~{test:{material:{kind:"bone"}}}] run function test:npc/cart/shop/sell_slot {slot:15,count:3,price:5}
execute if items entity @s container.16 *[minecraft:custom_data~{test:{material:{kind:"bone"}}}] run function test:npc/cart/shop/sell_slot {slot:16,count:3,price:5}
execute if items entity @s container.17 *[minecraft:custom_data~{test:{material:{kind:"bone"}}}] run function test:npc/cart/shop/sell_slot {slot:17,count:3,price:5}
execute if items entity @s container.14 *[minecraft:custom_data~{test:{material:{kind:"herb_leaf"}}}] run function test:npc/cart/shop/sell_slot {slot:14,count:2,price:8}
execute if items entity @s container.15 *[minecraft:custom_data~{test:{material:{kind:"herb_leaf"}}}] run function test:npc/cart/shop/sell_slot {slot:15,count:2,price:8}
execute if items entity @s container.16 *[minecraft:custom_data~{test:{material:{kind:"herb_leaf"}}}] run function test:npc/cart/shop/sell_slot {slot:16,count:2,price:8}
execute if items entity @s container.17 *[minecraft:custom_data~{test:{material:{kind:"herb_leaf"}}}] run function test:npc/cart/shop/sell_slot {slot:17,count:2,price:8}
