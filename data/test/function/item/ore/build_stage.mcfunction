#> test:item/ore/build_stage
# @macro stage/prefix/model/name: 段階・名前の頭・見た目・原石の名前。loot.item(test:item/ore/build が作った原石)を加工途中の原石にする

$data modify storage test: loot.item.components."minecraft:custom_data".test.ore.stage set value $(stage)
$data modify storage test: loot.item.components."minecraft:item_model" set value "$(model)"
$data modify storage test: loot.item.components."minecraft:custom_name".text set value "$(prefix)$(name)"
