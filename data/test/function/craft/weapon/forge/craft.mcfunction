#> test:craft/weapon/forge/craft
# @s = 鍛冶場マーカー。スロット9の素材(kind)で武器の種類、スロット10の触媒(kind)でティアを決める。スロット9の個数はサブステータスのレアリティに影響する
# スロット11に「範囲攻撃の核」(kind:aoe_core)があれば、生成される武器に右クリック範囲攻撃を付与する

data remove storage test: loot.item
data remove storage test: loot.rare
data remove storage test: loot.aoe_core

execute unless data block ~ ~ ~ Items[{Slot:9b}].components."minecraft:custom_data".test.material.kind run return 0

scoreboard players set #forge_count test.temporary 0
execute store result score #forge_count test.temporary run data get block ~ ~ ~ Items[{Slot:9b}].count

execute if score #forge_count test.temporary matches 5..9 run data modify storage test: loot.rare set value 3
execute if score #forge_count test.temporary matches 10..19 run data modify storage test: loot.rare set value 4
execute if score #forge_count test.temporary matches 20.. run data modify storage test: loot.rare set value 5

data modify storage test: loot.base_kind set from block ~ ~ ~ Items[{Slot:9b}].components."minecraft:custom_data".test.material.kind

data modify storage test: loot.catalyst_kind set value "none"
execute if data block ~ ~ ~ Items[{Slot:10b}].components."minecraft:custom_data".test.material.kind run data modify storage test: loot.catalyst_kind set from block ~ ~ ~ Items[{Slot:10b}].components."minecraft:custom_data".test.material.kind

execute if data block ~ ~ ~ Items[{Slot:11b}].components."minecraft:custom_data".test{material:{kind:"aoe_core"}} run data modify storage test: loot.aoe_core set value 1b

function test:craft/weapon/forge/recipe with storage test: loot

data remove block ~ ~ ~ Items[{Slot:9b}]
data remove block ~ ~ ~ Items[{Slot:10b}]
data remove block ~ ~ ~ Items[{Slot:11b}]
