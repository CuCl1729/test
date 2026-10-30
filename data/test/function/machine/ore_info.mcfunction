#> test:machine/ore_info
# @s = 機械のマーカー。処理中の原石の custom_data.test.ore から machine_work.ore = {machine, kind, rare, stage} を作り、
# #ore_rare1(レア度 − 1)と #ore_stage(段階。原石は0)をスコアにする

data modify storage test: machine_work.ore set value {machine:"",kind:"",rare:1,stage:0}
data modify storage test: machine_work.ore.machine set from storage test: machine_work.def.id
data modify storage test: machine_work.ore.kind set from entity @s data.machine.processing.components."minecraft:custom_data".test.ore.kind
data modify storage test: machine_work.ore.rare set from entity @s data.machine.processing.components."minecraft:custom_data".test.ore.rare
execute if data entity @s data.machine.processing.components."minecraft:custom_data".test.ore.stage run data modify storage test: machine_work.ore.stage set from entity @s data.machine.processing.components."minecraft:custom_data".test.ore.stage
execute store result score #ore_rare1 test.temporary run data get storage test: machine_work.ore.rare
scoreboard players remove #ore_rare1 test.temporary 1
execute store result score #ore_stage test.temporary run data get storage test: machine_work.ore.stage
