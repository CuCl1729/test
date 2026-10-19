#> test:item/weapon/lore/header
# @macro title: 区切りの空行と、灰色の見出しを1行ずつ足す

data modify storage test: loot.item.components."minecraft:lore" append value [{text:""}]
$data modify storage test: loot.item.components."minecraft:lore" append value [{text:"$(title)",italic:false,color:"gray"}]
