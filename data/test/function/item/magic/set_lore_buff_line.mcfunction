#> test:item/magic/set_lore_buff_line
# @macro = バフのレジストリ1件 + stacks。ロアに「付与: <名前> x<数> (<秒>秒)」を1行足す

$data modify storage test: loot.item.components.minecraft:lore append value [{italic:0b,color:gray,text:"付与: "},{italic:0b,color:"$(color)",text:"$(label)"},{italic:0b,color:gray,text:" x$(stacks) ($(duration)秒)"}]
