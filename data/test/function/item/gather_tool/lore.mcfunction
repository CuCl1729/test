#> test:item/gather_tool/lore
# @macro rank: 道具のランク(ほかのキーも渡ってくるが使わない)。説明を「採取 ランク<N>」にする

$data modify storage test: loot.item.components."minecraft:lore" set value [{text:"採取 ランク$(rank)",color:"gray",italic:false}]
