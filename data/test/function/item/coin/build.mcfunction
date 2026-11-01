#> test:item/coin/build
# @macro value: コインの値(1 / 10 / 100)。loot.item に作る(個数は呼び出し側)。元のアイテムは素材と同じ共通のもの、
# custom_data.test.coin = <値>、見た目と名前は asset.coin.v<値>

$execute unless data storage test: asset.coin.v$(value) run return 0
data remove storage test: loot.item
$data modify storage test: loot.item set value {id:"minecraft:recovery_compass",components:{"minecraft:custom_data":{test:{coin:$(value)}},"minecraft:custom_name":{text:"",italic:false}}}
$data modify storage test: loot.item.components."minecraft:item_model" set from storage test: asset.coin.v$(value).model
$data modify storage test: loot.item.components."minecraft:custom_name".text set from storage test: asset.coin.v$(value).name
$data modify storage test: loot.item.components."minecraft:custom_name".color set from storage test: asset.coin.v$(value).color
return 1
