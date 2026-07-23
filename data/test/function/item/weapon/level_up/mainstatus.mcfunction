$execute store result score #status test.temporary run data get storage test: loot.table.grow[{type:$(status_bonus)}].value 100

scoreboard players operation #status_bonus test.temporary += #status test.temporary
execute store result storage test: loot.item.components."minecraft:custom_data".status_bonus.value double 0.01 run scoreboard players get #status_bonus test.temporary

$execute store result score #status test.temporary run data get storage test: loot.table.grow[{type:$(base_status)}].value 100

scoreboard players operation #base_status test.temporary += #status test.temporary
execute store result storage test: loot.item.components."minecraft:custom_data".base_status.value double 0.01 run scoreboard players get #base_status test.temporary
