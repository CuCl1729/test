#> test:machine/give_egg
# @s = 渡す位置(機械のマーカーやプレイヤー)。@macro id: 機械の種類。使うとその場に機械を置けるスポーンエッグを渡す
# (station/give_egg と同じ形。置いたときは test:trigger/place → test:machine/place)。
# 機械は工場(test:factory。サバイバル)の中でだけ置ける。外(アドベンチャー)ではエッグをブロックに使えず、使えても place が返す

data remove storage test: loot.item
data modify storage test: loot.item.id set value "minecraft:allay_spawn_egg"
$data modify storage test: loot.item.components.entity_data set value {id:"armor_stand",Tags:["machine","summoned"],Invulnerable:1b,Invisible:1b,Marker:1b,NoGravity:1b,data:{machine:{id:"$(id)"}}}
data modify storage test: loot.item.components."minecraft:custom_name" set value {text:"",italic:false}
$data modify storage test: loot.item.components."minecraft:custom_name".text set from storage test: asset.machine.$(id).name

function test:loot/give
