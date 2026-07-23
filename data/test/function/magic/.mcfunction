function #oh_my_dat:please

execute store result score #cost test.status.mp run data get storage test: magic.player.cost
function test:status/update {"status":"magic_efficiency"}
scoreboard players operation #cost test.status.magic_efficiency = @s test.status.magic_efficiency

scoreboard players operation #cost test.status.mp += @s test.status.burnout
execute if score @s test.status.mp < #cost test.status.mp run return fail
scoreboard players operation @s test.status.mp -= #cost test.status.mp
scoreboard players operation #cost test.status.mp *= #10 test.constant
scoreboard players operation #cost test.status.mp /= #cost test.status.magic_efficiency
scoreboard players operation @s test.status.burnout += #cost test.status.mp

execute store result score @s test.temporary run data get storage test: magic.player.magic_damage_bonus

scoreboard players set @s test.fire_damage.bonus 100
scoreboard players operation @s test.fire_damage.bonus += @s test.temporary

scoreboard players set @s test.water_damage.bonus 100
scoreboard players operation @s test.water_damage.bonus += @s test.temporary

scoreboard players set @s test.wood_damage.bonus 100
scoreboard players operation @s test.wood_damage.bonus += @s test.temporary

scoreboard players set @s test.metal_damage.bonus 100
scoreboard players operation @s test.metal_damage.bonus += @s test.temporary

scoreboard players set @s test.earth_damage.bonus 100
scoreboard players operation @s test.earth_damage.bonus += @s test.temporary

scoreboard players set @s test.physics_damage.bonus 100
scoreboard players operation @s test.physics_damage.bonus += @s test.temporary

function test:damage/pre_magic
function test:status/update {status:effect_damage}

scoreboard players operation @s test.fire_damage *= @s test.status.effect_damage
scoreboard players operation @s test.fire_damage /= #10000 test.constant

scoreboard players operation @s test.water_damage *= @s test.status.effect_damage
scoreboard players operation @s test.water_damage /= #10000 test.constant

scoreboard players operation @s test.wood_damage *= @s test.status.effect_damage
scoreboard players operation @s test.wood_damage /= #10000 test.constant

scoreboard players operation @s test.metal_damage *= @s test.status.effect_damage
scoreboard players operation @s test.metal_damage /= #10000 test.constant

scoreboard players operation @s test.earth_damage *= @s test.status.effect_damage
scoreboard players operation @s test.earth_damage /= #10000 test.constant

execute if data storage test: magic.player{magic_type:"projectile"} run function test:magic/projectile/cast
execute if data storage test: magic.player{magic_type:"self"} run function test:magic/self/cast