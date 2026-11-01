#> test:npc/cart/bank/populate
# @s = 銀行のトロッコ(実行位置も @s)。@macro npc/pid: 銀行員と持ち主の番号。銀行の画面を描く:
#   0〜17 預ける枠(置いたコインはそのまま口座に入る。test:npc/cart/bank/tick)/ 18 所持金 / 20 [全部預ける] /
#   22〜25 [1・10・100・1000引き出す] / 26 [全部引き出す]

tag @s add cart_bank
data modify storage test: cart_work.keep set value {s0:1b,s1:1b,s2:1b,s3:1b,s4:1b,s5:1b,s6:1b,s7:1b,s8:1b,s9:1b,s10:1b,s11:1b,s12:1b,s13:1b,s14:1b,s15:1b,s16:1b,s17:1b}
$data modify entity @s Items append value {Slot:20b,id:"minecraft:chest",count:1,components:{"minecraft:custom_name":{text:"[全部預ける]",color:"green",italic:false},"minecraft:custom_data":{test:{shop_ui:{cart:$(pid),npc:"$(npc)",act:"deposit_all"}}}}}
$data modify entity @s Items append value {Slot:22b,id:"minecraft:copper_nugget",count:1,components:{"minecraft:custom_name":{text:"[1G引き出す]",color:"aqua",italic:false},"minecraft:custom_data":{test:{shop_ui:{cart:$(pid),npc:"$(npc)",act:"withdraw",n:1}}}}}
$data modify entity @s Items append value {Slot:23b,id:"minecraft:iron_nugget",count:1,components:{"minecraft:custom_name":{text:"[10G引き出す]",color:"aqua",italic:false},"minecraft:custom_data":{test:{shop_ui:{cart:$(pid),npc:"$(npc)",act:"withdraw",n:10}}}}}
$data modify entity @s Items append value {Slot:24b,id:"minecraft:gold_nugget",count:1,components:{"minecraft:custom_name":{text:"[100G引き出す]",color:"aqua",italic:false},"minecraft:custom_data":{test:{shop_ui:{cart:$(pid),npc:"$(npc)",act:"withdraw",n:100}}}}}
$data modify entity @s Items append value {Slot:25b,id:"minecraft:gold_ingot",count:1,components:{"minecraft:custom_name":{text:"[1000G引き出す]",color:"aqua",italic:false},"minecraft:custom_data":{test:{shop_ui:{cart:$(pid),npc:"$(npc)",act:"withdraw",n:1000}}}}}
$data modify entity @s Items append value {Slot:26b,id:"minecraft:gold_block",count:1,components:{"minecraft:custom_name":{text:"[全部引き出す]",color:"aqua",italic:false},"minecraft:custom_data":{test:{shop_ui:{cart:$(pid),npc:"$(npc)",act:"withdraw_all"}}}}}
function test:npc/cart/info
