#> test:item/give_built
# @s = 受け取るプレイヤー。loot.item(作り終えたもの)を、そのまま持ち物に入れる(test:item/material/give と同じ入れ方)

execute in minecraft:overworld run item replace block 0 -64 0 container.0 with stone
execute in minecraft:overworld run data modify block 0 -64 0 Items[{Slot:0b}] merge from storage test: loot.item
execute in minecraft:overworld run loot give @s mine 0 -64 0 debug_stick
