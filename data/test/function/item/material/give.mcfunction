#> test:item/material/give
# @s = 受け取るプレイヤー。@macro id/count: 素材のidと個数。素材を作って(test:item/material/build)インベントリに直接渡す。
# test:loot/give は説明文の邪魔な項目を隠す tooltip_display を足すので通さない(足すと、別の方法で手に入れた
# 同じ素材と重ならなくなる)。組み立て場所は loot/give と同じオーバーワールドの 0 -64 0。定義が無ければ0、渡したら1を返す

scoreboard players set #material_built test.temporary 0
$execute store result score #material_built test.temporary run function test:item/material/build {id:"$(id)"}
execute if score #material_built test.temporary matches 0 run return 0

$data modify storage test: loot.item.count set value $(count)
execute in minecraft:overworld run item replace block 0 -64 0 container.0 with stone
execute in minecraft:overworld run data modify block 0 -64 0 Items[{Slot:0b}] merge from storage test: loot.item
execute in minecraft:overworld run loot give @s mine 0 -64 0 debug_stick
return 1
