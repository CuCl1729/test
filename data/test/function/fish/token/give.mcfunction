#> test:fish/token/give
# @s = プレイヤー。@macro material/min/max: 選ばれた行。個数(rng のキー fish_count)ぶんの素材を足元に落とし、1を返す

$execute store result score #fish_count test.temporary run function test:rng/roll {key:"fish_count",min:$(min),max:$(max)}
$execute store result score #fish_built test.temporary run function test:item/material/build {id:"$(material)"}
execute if score #fish_built test.temporary matches 0 run return 1
execute store result storage test: loot.item.count int 1 run scoreboard players get #fish_count test.temporary
execute at @s run function test:item/drop_at
$function test:debug/log {msg:" $(material)"}
return 1
