say critical

scoreboard players operation #victim test.fire_damage *= #damage test.status.crit_damage
scoreboard players operation #victim test.fire_damage /= #100 test.constant

scoreboard players operation #victim test.water_damage *= #damage test.status.crit_damage
scoreboard players operation #victim test.water_damage /= #100 test.constant

scoreboard players operation #victim test.wood_damage *= #damage test.status.crit_damage
scoreboard players operation #victim test.wood_damage /= #100 test.constant

scoreboard players operation #victim test.metal_damage *= #damage test.status.crit_damage
scoreboard players operation #victim test.metal_damage /= #100 test.constant

scoreboard players operation #victim test.earth_damage *= #damage test.status.crit_damage
scoreboard players operation #victim test.earth_damage /= #100 test.constant

scoreboard players operation #victim test.physics_damage *= #damage test.status.crit_damage
scoreboard players operation #victim test.physics_damage /= #100 test.constant
