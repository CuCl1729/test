#> test:craft/custom/out/vanilla
# @macro id: バニラのアイテムのid(minecraft: を省いたもの)。custom_data を付けない。loot.item に作る(個数は test:craft/custom/place_out が入れる)

data remove storage test: loot.item
$data modify storage test: loot.item.id set value "minecraft:$(id)"
