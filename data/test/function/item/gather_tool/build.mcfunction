#> test:item/gather_tool/build
# @macro id: 採取の道具のid(asset.gather_tool.<id>)。storage test: loot.item に作る。custom_data.test.gather_tool = {id, kind, rank}。
# 元のアイテムは素材と同じ共通のもの(バニラの道具として使えないように)で、見た目は item_model。定義が無いidなら0、作れたら1を返す

$execute unless data storage test: asset.gather_tool.$(id) run return 0
data remove storage test: loot.item
$data modify storage test: loot.item.id set from storage test: asset.gather_tool.$(id).item
$data modify storage test: loot.item.components."minecraft:item_model" set from storage test: asset.gather_tool.$(id).model
$data modify storage test: loot.item.components."minecraft:custom_data" set value {test:{gather_tool:{id:"$(id)",kind:"",rank:0}}}
$data modify storage test: loot.item.components."minecraft:custom_data".test.gather_tool.kind set from storage test: asset.gather_tool.$(id).kind
$data modify storage test: loot.item.components."minecraft:custom_data".test.gather_tool.rank set from storage test: asset.gather_tool.$(id).rank
data modify storage test: loot.item.components."minecraft:custom_name" set value {text:"",italic:false}
$data modify storage test: loot.item.components."minecraft:custom_name".text set from storage test: asset.gather_tool.$(id).name
data modify storage test: loot.item.components."minecraft:max_stack_size" set value 1
$function test:item/gather_tool/lore with storage test: asset.gather_tool.$(id)
return 1
