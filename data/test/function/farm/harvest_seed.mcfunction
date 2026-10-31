#> test:farm/harvest_seed
# @s = プレイヤー。@macro id: 魔法作物のid(farm_work.t。ほかのキーも渡ってくるが使わない)。収穫で増えた種を足元に落とす

$execute store result score #seed_built test.temporary run function test:item/magic_seed/build {id:"$(id)"}
execute if score #seed_built test.temporary matches 1 at @s run function test:item/drop_at
