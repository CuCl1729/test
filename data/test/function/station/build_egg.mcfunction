#> test:station/build_egg
# @macro id: ステーションの種類。ステーションを置けるスポーンエッグを loot.item に作る(test:station/give_egg とカスタムクラフターが使う)。
# custom_data.test.egg = "station:<id>" は、カスタムクラフターが取り返すときにほかのエッグと見分けるための目印

data remove storage test: loot.item
data modify storage test: loot.item.id set value "minecraft:allay_spawn_egg"
$data modify storage test: loot.item.components.entity_data set value {id:"armor_stand",Tags:["station","summoned"],Invulnerable:1b,Invisible:0b,Marker:1b,data:{station:{id:"$(id)",mode:0}}}
data modify storage test: loot.item.components."minecraft:custom_name" set value {text:"",italic:false}
$data modify storage test: loot.item.components."minecraft:custom_name".text set from storage test: asset.station.$(id).name
$data modify storage test: loot.item.components."minecraft:custom_data" set value {test:{egg:"station:$(id)"}}
