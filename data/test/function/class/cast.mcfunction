data remove entity @n[predicate=test:projectile/is_class_manager] Tags[]

execute unless data entity @s Tags[] run return run scoreboard players set @s test.boolean 0

data modify entity @e[limit=1,predicate=test:projectile/is_class_manager] Tags append from entity @s Tags[]

$data modify entity @e[limit=1,predicate=test:projectile/is_class_manager] Tags append from storage test: class.declare.$(class).child[]

execute store result score #tags test.temporary if data entity @s Tags[]

$execute store result score #class test.temporary if data storage test: class.declare.$(class).child[]

scoreboard players operation #tags test.temporary += #class test.temporary

execute store result score #class test.temporary if data entity @e[limit=1,predicate=test:projectile/is_class_manager] Tags[]

data modify entity @e[limit=1,predicate=test:projectile/is_class_manager] Tags set value []

execute if score #tags test.temporary = #class test.temporary run scoreboard players set @s test.boolean 0
execute unless score #tags test.temporary = #class test.temporary run scoreboard players set @s test.boolean 1
