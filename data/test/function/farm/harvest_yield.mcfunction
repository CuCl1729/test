#> test:farm/harvest_yield
# @s = プレイヤー。@macro essence/min/max/seed_chance: 魔法作物の定義(ほかのキーも渡ってくるが使わない)

$execute store result score #farm_yield test.temporary run function test:rng/roll {key:"crop_yield",min:$(min),max:$(max)}
$execute store result score #farm_built test.temporary run function test:item/material/build {id:"$(essence)"}
execute if score #farm_built test.temporary matches 1 store result storage test: loot.item.count int 1 run scoreboard players get #farm_yield test.temporary
execute if score #farm_built test.temporary matches 1 at @s run function test:item/drop_at
execute store result score #farm_roll test.temporary run function test:rng/roll {key:"crop_seed",min:1,max:100}
$execute if score #farm_roll test.temporary matches ..$(seed_chance) run function test:farm/harvest_seed with storage test: farm_work.t
data modify storage test: farm_work.log set value {yield:0,roll:0}
execute store result storage test: farm_work.log.yield int 1 run scoreboard players get #farm_yield test.temporary
execute store result storage test: farm_work.log.roll int 1 run scoreboard players get #farm_roll test.temporary
function test:farm/harvest_log with storage test: farm_work.log
