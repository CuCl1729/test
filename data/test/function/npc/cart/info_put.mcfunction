#> test:npc/cart/info_put
# @s = トロッコ。@macro bank/coins/pid/npc: 所持金の表示をスロット18に置く

data remove entity @s Items[{Slot:18b}]
$data modify entity @s Items append value {Slot:18b,id:"minecraft:gold_ingot",count:1,components:{"minecraft:custom_name":{text:"所持金",color:"gold",italic:false},"minecraft:lore":[{text:"口座 $(bank)G",color:"yellow",italic:false},{text:"コイン $(coins)G",color:"yellow",italic:false}],"minecraft:custom_data":{test:{shop_ui:{cart:$(pid),npc:"$(npc)",act:"none"}}}}}
