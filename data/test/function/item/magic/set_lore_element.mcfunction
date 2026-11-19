#> test:item/magic/set_lore_element
# @macro id: 属性id  @macro label: 表示名  @macro color: 表示色
# その属性の基礎ダメージ(data.magic.<id>.base)が実在する魔法アイテムにだけダメージ行を追加する

$execute if data storage test: loot.item.components.minecraft:custom_data.test.data.magic.$(id).base run data modify storage test: loot.item.components.minecraft:lore append value [{italic:0b,color:"$(color)",text:"$(label)ダメージ:"}]
$execute if data storage test: loot.item.components.minecraft:custom_data.test.data.magic.$(id).base run data modify entity @n[tag=text] text set value {color:aqua,type:"nbt",storage:"test:",nbt:"loot.item.components.minecraft:custom_data.test.data.magic.$(id).base"}
$execute if data storage test: loot.item.components.minecraft:custom_data.test.data.magic.$(id).base run data modify storage test: loot.item.components.minecraft:lore[-1] append from entity @n[tag=text] text
