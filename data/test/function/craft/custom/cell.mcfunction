#> test:craft/custom/cell
# 実行位置 = 樽。@macro slot/i: 材料の枠のスロットと、9マスの何番目か。#cn<i> に数、craft_work.cells.c<i> に1マスの文字を入れる。
# 素材(custom_data.test.material.kind / エッセンスは test.essence.kind)は m:<id>、custom_data の無いアイテムは v:<id>。
# それ以外のアイテム(ツルハシ・原石など)は材料にできないので craft_work.bad = 1b

$scoreboard players set #cn$(i) test.temporary 0
$execute unless data block ~ ~ ~ Items[{Slot:$(slot)b}] run return 0
$data modify storage test: craft_work.it set from block ~ ~ ~ Items[{Slot:$(slot)b}]
$execute store result score #cn$(i) test.temporary run data get storage test: craft_work.it.count
$data modify storage test: craft_work.ca set value {i:$(i),v:""}
data modify storage test: craft_work.ca.v set from storage test: craft_work.it.components."minecraft:custom_data".test.material.kind
data modify storage test: craft_work.ca.v set from storage test: craft_work.it.components."minecraft:custom_data".test.essence.kind
execute unless data storage test: craft_work.ca{v:""} run return run function test:craft/custom/cell_m with storage test: craft_work.ca
execute if data storage test: craft_work.it.components."minecraft:custom_data" run return run data modify storage test: craft_work.bad set value 1b
data modify storage test: craft_work.ca.v set from storage test: craft_work.it.id
function test:craft/custom/cell_v with storage test: craft_work.ca
