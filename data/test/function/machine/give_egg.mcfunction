#> test:machine/give_egg
# @s = 渡す位置(機械のマーカーやプレイヤー)。@macro id: 機械の種類。使うとその場に機械を置けるスポーンエッグを渡す
# (station/give_egg と同じ形。置いたときは test:trigger/place → test:machine/place)。
# アドベンチャーモードでは、can_place_on が無いとエッグをブロックに使えないので、床(#test:machine_floor)に使えるようにする

data remove storage test: loot.item
data modify storage test: loot.item.id set value "minecraft:allay_spawn_egg"
$data modify storage test: loot.item.components.entity_data set value {id:"armor_stand",Tags:["machine","summoned"],Invulnerable:1b,Invisible:1b,Marker:1b,NoGravity:1b,data:{machine:{id:"$(id)"}}}
data modify storage test: loot.item.components."minecraft:custom_name" set value {text:"",italic:false}
$data modify storage test: loot.item.components."minecraft:custom_name".text set from storage test: asset.machine.$(id).name
data modify storage test: loot.item.components."minecraft:can_place_on" set value {blocks:"#test:machine_floor"}
data modify storage test: loot.item.components."minecraft:tooltip_display" set value {hidden_components:["minecraft:can_place_on"]}

function test:loot/give
