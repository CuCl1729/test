#> test:station/give_egg
# @s = 渡す位置(ステーションのマーカーやプレイヤー)。@macro id: ステーションの種類。
# 使うとその場にステーションを置けるスポーンエッグを渡す(置いたときは test:trigger/place → test:station/place)

data remove storage test: loot.item
data modify storage test: loot.item.id set value "minecraft:allay_spawn_egg"
$data modify storage test: loot.item.components.entity_data set value {id:"armor_stand",Tags:["station","summoned"],Invulnerable:1b,Invisible:0b,Marker:1b,data:{station:{id:"$(id)",mode:0}}}
data modify storage test: loot.item.components."minecraft:custom_name" set value {text:"",italic:false}
$data modify storage test: loot.item.components."minecraft:custom_name".text set from storage test: asset.station.$(id).name

function test:loot/give
