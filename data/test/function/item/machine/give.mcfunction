#> test:item/machine/give
# @s = 受け取るプレイヤー。@macro id/count: 組み立てに使うアイテムのidと個数。インベントリに直接渡す
# (test:item/material/give と同じ。test:loot/give は tooltip_display を足して、壊して拾ったものと重ならなくなるので通さない)。
# 定義が無ければ0、渡したら1を返す

scoreboard players set #machine_built test.temporary 0
$execute store result score #machine_built test.temporary run function test:item/machine/build {id:"$(id)"}
execute if score #machine_built test.temporary matches 0 run return 0

$data modify storage test: loot.item.count set value $(count)
execute in minecraft:overworld run item replace block 0 -64 0 container.0 with stone
execute in minecraft:overworld run data modify block 0 -64 0 Items[{Slot:0b}] merge from storage test: loot.item
execute in minecraft:overworld run loot give @s mine 0 -64 0 debug_stick
return 1
