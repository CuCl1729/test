#> test:gather/drop/row
# @s = 採るプレイヤー。@macro material/chance/chance_rank/min/max: 中身の1行。当たったら、個数(rng のキー gather_count)ぶんの素材を
# 足元に落とす(すぐ拾う。持ち物がいっぱいでも消えない。素材は item/material/build で作るので、ほかで手に入れた同じ素材と重なる)

$scoreboard players set #gather_chance test.temporary $(chance_rank)
scoreboard players operation #gather_chance test.temporary *= #gather_rank test.temporary
$scoreboard players add #gather_chance test.temporary $(chance)
execute if score #gather_chance test.temporary matches 101.. run scoreboard players set #gather_chance test.temporary 100
execute store result score #gather_roll test.temporary run function test:rng/roll {key:"gather_drop",min:1,max:100}
$execute if score #gather_roll test.temporary > #gather_chance test.temporary run return run function test:debug/log {msg:" $(material): はずれ"}

$execute store result score #gather_count test.temporary run function test:rng/roll {key:"gather_count",min:$(min),max:$(max)}
$execute store result score #gather_built test.temporary run function test:item/material/build {id:"$(material)"}
execute if score #gather_built test.temporary matches 0 run return 0
execute store result storage test: loot.item.count int 1 run scoreboard players get #gather_count test.temporary
execute at @s run function test:item/drop_at
$function test:debug/log {msg:" $(material): 当たり"}
