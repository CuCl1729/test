#> test:mine/egg/give
# @s = 渡す相手。@macro id: 鉱脈のid。使った場所(その面の手前のブロックの角)に、両マップで鉱脈のアマスタを置く
# スポーンエッグを渡す(使ったときは test:trigger/place → test:mine/egg/place)。名前はその鉱脈の原石
data remove storage test: loot.item
data modify storage test: loot.item.id set value "minecraft:silverfish_spawn_egg"
$data modify storage test: loot.item.components.entity_data set value {id:"armor_stand",Tags:["vein_egg","summoned"],Marker:1b,Invisible:1b,data:{egg:"$(id)"}}
data modify storage test: loot.item.components."minecraft:custom_name" set value [{text:"鉱脈: ",italic:false,color:"gold"},{text:"",italic:false,color:"white"}]
$function test:mine/egg/name with storage test: asset.vein.$(id)
data modify storage test: loot.item.components."minecraft:lore" set value [{text:"両マップに置く",italic:false,color:"gray"}]
$data modify storage test: loot.item.components."minecraft:custom_data" set value {test:{egg:"vein:$(id)"}}
function test:loot/give
