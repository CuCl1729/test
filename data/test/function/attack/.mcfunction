say attack
data modify storage test: attack.player set from storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.SelectedItem.components.minecraft:custom_data

execute store result score @s test.repeat run data get storage test: attack.player.weapon[{type:"reach"}].value

function test:damage/pre_attack
function test:status/update {status:crit_rate}
function test:status/update {status:crit_damage}

scoreboard players operation #damage test.status.crit_rate = @s test.status.crit_rate

scoreboard players operation @s test.status.crit_damage /= #100 test.constant
scoreboard players operation #damage test.status.crit_damage = @s test.status.crit_damage

scoreboard players operation #damage test.def.pene = @s test.def.pene

scoreboard players operation #damage test.fire_resist.pene = @s test.fire_resist.pene
scoreboard players operation #damage test.water_resist.pene = @s test.water_resist.pene
scoreboard players operation #damage test.wood_resist.pene = @s test.wood_resist.pene
scoreboard players operation #damage test.metal_resist.pene = @s test.metal_resist.pene
scoreboard players operation #damage test.earth_resist.pene = @s test.earth_resist.pene
scoreboard players operation #damage test.physics_resist.pene = @s test.physics_resist.pene

scoreboard players operation #damage test.fire_damage = @s test.fire_damage
scoreboard players operation #damage test.water_damage = @s test.water_damage
scoreboard players operation #damage test.wood_damage = @s test.wood_damage
scoreboard players operation #damage test.metal_damage = @s test.metal_damage
scoreboard players operation #damage test.earth_damage = @s test.earth_damage
scoreboard players operation #damage test.physics_damage = @s test.physics_damage

execute anchored eyes positioned ^ ^ ^0.5 run function test:scan/ray_cast/
