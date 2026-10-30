#> test:item/drop_at
# storage test: loot.item を、実行位置(どのディメンションでもよい)にアイテムとして落とす。動き(Motion)は0にするので、
# 真下にホッパーがあればそのまま吸い込まれる。組み立てはオーバーワールドの 0 -64 0 で行う(test:item/ore/drop_rest と同じ)。
# 落とす位置は、組み立ての間に別のディメンションへ移るので、目印の marker(tag=drop_at)を置いて覚えておく

summon marker ~ ~ ~ {Tags:["drop_at"]}
execute in minecraft:overworld run item replace block 0 -64 0 container.0 with stone
execute in minecraft:overworld run data modify block 0 -64 0 Items[{Slot:0b}] merge from storage test: loot.item
execute in minecraft:overworld run loot spawn 0 -64 1 mine 0 -64 0 debug_stick
execute in minecraft:overworld positioned 0 -64 1 as @n[type=item,distance=..2] run function test:item/drop_at_move
kill @e[type=marker,tag=drop_at]
