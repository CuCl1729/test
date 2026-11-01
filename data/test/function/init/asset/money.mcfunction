#> test:init/asset/money
# コインの種類(値 => 見た目・名前)。test:item/coin/build {value} が読む。口座はスコア test.money(test:money/)

data modify storage test: asset.coin set value {}
data modify storage test: asset.coin.v1 set value {model:"minecraft:copper_nugget",name:"銅貨",color:"gold"}
data modify storage test: asset.coin.v10 set value {model:"minecraft:iron_nugget",name:"銀貨",color:"white"}
data modify storage test: asset.coin.v100 set value {model:"minecraft:gold_nugget",name:"金貨",color:"yellow"}
