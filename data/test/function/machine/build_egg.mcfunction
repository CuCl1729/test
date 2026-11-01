#> test:machine/build_egg
# @macro id: 機械の種類。機械を置けるスポーンエッグを loot.item に作る(test:machine/give_egg とカスタムクラフターが使う)。
# custom_data.test.egg = "machine:<id>" は、カスタムクラフターが取り返すときにほかのエッグと見分けるための目印

data remove storage test: loot.item
data modify storage test: loot.item.id set value "minecraft:allay_spawn_egg"
$data modify storage test: loot.item.components.entity_data set value {id:"armor_stand",Tags:["machine","summoned"],Invulnerable:1b,Invisible:1b,Marker:1b,NoGravity:1b,data:{machine:{id:"$(id)"}}}
data modify storage test: loot.item.components."minecraft:custom_name" set value {text:"",italic:false}
$data modify storage test: loot.item.components."minecraft:custom_name".text set from storage test: asset.machine.$(id).name
$data modify storage test: loot.item.components."minecraft:custom_data" set value {test:{egg:"machine:$(id)"}}
