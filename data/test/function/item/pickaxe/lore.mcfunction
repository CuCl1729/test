#> test:item/pickaxe/lore
# @macro rank: ツルハシのランク(ほかのキーも渡ってくるが使わない)。説明文を「⛏ ランク 2」の1行にする

$data modify storage test: loot.item.components."minecraft:lore" set value [[{text:"⛏ ランク ",color:"gray",italic:false},{text:"$(rank)",color:"aqua",italic:false}]]
