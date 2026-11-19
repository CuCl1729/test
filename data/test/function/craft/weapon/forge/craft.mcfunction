#> test:craft/weapon/forge/craft
# @s = 鍛冶場マーカー。スロット9の素材(kind)で武器の種類、スロット10の触媒(kind)でティアを決める。スロット9の個数はサブステータスのレアリティに影響する
# 特殊素材は、素材・触媒以外の空きスロットのどこに置いても効く(以前はスロット11/12に固定していたが、
# GUIに割り当てが書かれておらず、置き場所を間違えると何も付かなかったため)
# 特殊素材効果(asset.action.materials)は forge_work.specials/active に収めてレシピ構築の間だけ存在させる。
# 通常の武器生成(鍛冶以外)はこの forge_work を一切見ないので、ここで漏れることはない

data remove storage test: loot.item
data remove storage test: loot.rare
data remove storage test: forge_work

execute unless data block ~ ~ ~ Items[{Slot:9b}].components."minecraft:custom_data".test.material.kind run return 0

scoreboard players set #forge_count test.temporary 0
execute store result score #forge_count test.temporary run data get block ~ ~ ~ Items[{Slot:9b}].count

execute if score #forge_count test.temporary matches 5..9 run data modify storage test: loot.rare set value 3
execute if score #forge_count test.temporary matches 10..19 run data modify storage test: loot.rare set value 4
execute if score #forge_count test.temporary matches 20.. run data modify storage test: loot.rare set value 5

data modify storage test: loot.base_kind set from block ~ ~ ~ Items[{Slot:9b}].components."minecraft:custom_data".test.material.kind

execute if data block ~ ~ ~ Items[{Slot:10b}] unless data block ~ ~ ~ Items[{Slot:10b}].components."minecraft:custom_data".test.material.kind run return run tellraw @p[distance=..6] {text:"この触媒では鍛造できません",color:"red"}
data modify storage test: loot.catalyst_kind set value "none"
execute if data block ~ ~ ~ Items[{Slot:10b}].components."minecraft:custom_data".test.material.kind run data modify storage test: loot.catalyst_kind set from block ~ ~ ~ Items[{Slot:10b}].components."minecraft:custom_data".test.material.kind

function test:action/material/collect

data modify storage test: forge_work.active set value 1b
function test:craft/weapon/forge/recipe with storage test: loot
data remove storage test: forge_work.active

execute unless data storage test: loot.item.id run data remove storage test: forge_work
execute unless data storage test: loot.item.id run return run tellraw @p[distance=..6] {text:"この組み合わせの鍛冶レシピはありません",color:"red"}

data remove block ~ ~ ~ Items[{Slot:9b}]
data remove block ~ ~ ~ Items[{Slot:10b}]
function test:action/material/consume
data remove storage test: forge_work
