#> test:npc/cart/shop/populate
# @s = 店のトロッコ(実行位置も @s)。@macro npc/pid/shop: 店員・持ち主の番号・店のid。店の画面を描く:
#   0〜13 品物の見本(14個ずつ。ページはトロッコのスコア test.npc.cart_page)/ 14〜17 売る枠(空けておく)/ 18 所持金 / 19 [売る] / 21・23 ページ送り

tag @s add cart_shop
data modify storage test: cart_work.keep set value {s14:1b,s15:1b,s16:1b,s17:1b}
scoreboard players add @s test.npc.cart_page 0
execute if score @s test.npc.cart_page matches ..-1 run scoreboard players set @s test.npc.cart_page 0
$data modify storage test: cart_work.sq set from storage test: asset.shop.$(shop).items
scoreboard players operation #skip test.temporary = @s test.npc.cart_page
scoreboard players set #n14 test.temporary 14
scoreboard players operation #skip test.temporary *= #n14 test.temporary
scoreboard players set #si test.temporary 0
function test:npc/cart/shop/skip
scoreboard players set #slot test.temporary 0
function test:npc/cart/shop/place_loop
$execute if score @s test.npc.cart_page matches 1.. run data modify entity @s Items append value {Slot:21b,id:"minecraft:arrow",count:1,components:{"minecraft:custom_name":{text:"◀ 前のページ",italic:false},"minecraft:custom_data":{test:{shop_ui:{cart:$(pid),npc:"$(npc)",act:"page_prev"}}}}}
$execute if data storage test: cart_work.sq[0] run data modify entity @s Items append value {Slot:23b,id:"minecraft:arrow",count:1,components:{"minecraft:custom_name":{text:"次のページ ▶",italic:false},"minecraft:custom_data":{test:{shop_ui:{cart:$(pid),npc:"$(npc)",act:"page_next"}}}}}
$data modify entity @s Items append value {Slot:19b,id:"minecraft:emerald",count:1,components:{"minecraft:custom_name":{text:"[売る]",color:"green",italic:false},"minecraft:lore":[{text:"売る枠に置いたものを売る",color:"gray",italic:false}],"minecraft:custom_data":{test:{shop_ui:{cart:$(pid),npc:"$(npc)",act:"sell"}}}}}
function test:npc/cart/info
