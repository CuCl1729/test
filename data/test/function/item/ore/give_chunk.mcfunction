#> test:item/ore/give_chunk
# @s = 受け取るプレイヤー。@macro id/rare: 原石の種類とレア度。#ore_give_left 個のうち最大64個を渡し、残りがあれば繰り返す

execute if score #ore_give_left test.temporary matches ..0 run return 0
scoreboard players set #ore_chunk test.temporary 64
execute if score #ore_give_left test.temporary < #ore_chunk test.temporary run scoreboard players operation #ore_chunk test.temporary = #ore_give_left test.temporary
scoreboard players operation #ore_give_left test.temporary -= #ore_chunk test.temporary

scoreboard players set #ore_built test.temporary 0
$execute store result score #ore_built test.temporary run function test:item/ore/build {id:"$(id)",rare:$(rare),stage:0}
execute if score #ore_built test.temporary matches 0 run return 0
execute store result storage test: loot.item.count int 1 run scoreboard players get #ore_chunk test.temporary

# 入れる前と後の個数の差で、実際に入った数を調べる
scoreboard players set #ore_before test.temporary 0
$execute store result score #ore_before test.temporary run clear @s *[custom_data~{test:{ore:{kind:"$(id)",rare:$(rare)}}}] 0
execute in minecraft:overworld run item replace block 0 -64 0 container.0 with stone
execute in minecraft:overworld run data modify block 0 -64 0 Items[{Slot:0b}] merge from storage test: loot.item
execute in minecraft:overworld run loot give @s mine 0 -64 0 debug_stick
scoreboard players set #ore_after test.temporary 0
$execute store result score #ore_after test.temporary run clear @s *[custom_data~{test:{ore:{kind:"$(id)",rare:$(rare)}}}] 0

# 入りきらなかった分を足元に落とす(組み立てはオーバーワールドで行い、できたアイテムを@sへ転送する。test:loot/give と同じ)
scoreboard players operation #ore_after test.temporary -= #ore_before test.temporary
scoreboard players operation #ore_chunk test.temporary -= #ore_after test.temporary
execute if score #ore_chunk test.temporary matches 1.. run function test:item/ore/drop_rest

$function test:item/ore/give_chunk {id:"$(id)",rare:$(rare)}
