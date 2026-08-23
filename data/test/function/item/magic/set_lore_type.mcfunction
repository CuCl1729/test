#> test:item/magic/set_lore_type
# @macro id: タイプid  @macro label: 表示名
# そのタイプが使われている魔法アイテムにだけタイプ名のロアを追加する

$execute if data storage test: loot.item.components.minecraft:custom_data.test.type_flags{$(id):1b} run data modify storage test: loot.item.components.minecraft:lore append value [{italic:0b,color:gray,text:"タイプ: $(label)"}]
