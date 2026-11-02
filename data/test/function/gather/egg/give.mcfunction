#> test:gather/egg/give
# @s = 渡す相手。@macro type: 採取物のid。使った場所に、その採取物の採取ポイントを置くスポーンエッグを渡す
# (使ったときは test:trigger/place → test:gather/egg/place)
data remove storage test: loot.item
data modify storage test: loot.item.id set value "minecraft:bee_spawn_egg"
$data modify storage test: loot.item.components.entity_data set value {id:"armor_stand",Tags:["gather_egg","summoned"],Marker:1b,Invisible:1b,data:{egg:"$(type)"}}
data modify storage test: loot.item.components."minecraft:custom_name" set value [{text:"採取: ",italic:false,color:"green"},{text:"",italic:false,color:"white"}]
$data modify storage test: loot.item.components."minecraft:custom_name"[1].text set from storage test: asset.gather.$(type).name
data modify storage test: loot.item.components."minecraft:lore" set value [{text:"両マップに置く",italic:false,color:"gray"}]
$data modify storage test: loot.item.components."minecraft:custom_data" set value {test:{egg:"gather:$(type)"}}
function test:loot/give
