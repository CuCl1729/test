#> test:magic/crafter/populate_preview
# @s = クラフター本体(barrelの位置)。現時点の magic.loot.status(効果)と magic.loot.name(名前)から、
# 実際にクラフトした場合と同じ形式のプレビューアイテムを組み立ててスロット22へ表示する。
# item/magic/give と同じ組み立て処理(item/magic/set_lore)を使い回すが、実際には渡さない

data remove storage test: loot.item
data modify storage test: loot.item.id set value "nether_star"
data modify storage test: loot.item.components.minecraft:custom_name set from storage test: magic.loot.name
data modify storage test: loot.item.components.minecraft:custom_data.test merge from storage test: magic.loot.status
execute store result storage test: loot.item.components.minecraft:custom_data.test.cost int 1 run scoreboard players get #cost test.temporary

# 誤って持っていかれても回収できるよう、UI用アイテムの目印を付けておく(test:magic/crafter/mainが回収する)
data modify storage test: loot.item.components.minecraft:custom_data.test.crafter_ui set value 1b

function test:item/magic/set_lore

# 現在の組み合わせが成立するかも合わせて表示する(判定はクラフト確定時と同じtest:magic/crafter/validate)
function test:magic/crafter/validate

execute if score #combo_invalid test.temporary matches 1 run data modify storage test: loot.item.components.minecraft:lore append value [{italic:0b,color:red,text:"組み合わせが不正です"}]
execute unless data storage test: magic.loot.status.magic_type run data modify storage test: loot.item.components.minecraft:lore append value [{italic:0b,color:gray,text:"要素を追加してください"}]
execute if data storage test: magic.loot.status.magic_type if score #combo_invalid test.temporary matches 0 run data modify storage test: loot.item.components.minecraft:lore append value [{italic:0b,color:green,text:"クラフトできます"}]

data remove block ~ ~ ~ Items[{Slot:22b}]
# id の無いアイテムは樽が読み込むときに捨てるので、丸ごと組み立ててから1回で足す
data modify storage test: loot.item.Slot set value 22b
data modify storage test: loot.item.count set value 1
data modify block ~ ~ ~ Items append from storage test: loot.item
