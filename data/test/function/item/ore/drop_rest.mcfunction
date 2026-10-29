#> test:item/ore/drop_rest
# @s = 受け取るプレイヤー。持ち物に入りきらなかった #ore_chunk 個(loot.item の原石)を、@s の足元に落とす

execute store result storage test: loot.item.count int 1 run scoreboard players get #ore_chunk test.temporary
execute in minecraft:overworld run item replace block 0 -64 0 container.0 with stone
execute in minecraft:overworld run data modify block 0 -64 0 Items[{Slot:0b}] merge from storage test: loot.item
execute in minecraft:overworld run loot spawn 0 -64 1 mine 0 -64 0 debug_stick
execute in minecraft:overworld positioned 0 -64 1 run tp @n[type=item,distance=..2] @s
