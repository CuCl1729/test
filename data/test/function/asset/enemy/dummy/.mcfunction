data remove storage test: enemy
data modify storage test: enemy.Tags set value [dummy]
data modify storage test: enemy.id set value armor_stand
data modify storage test: enemy.data.loot_table set value "test:enemy/dummy"

scoreboard players set #enemy test.status.atk 100
scoreboard players set #enemy test.status.crit_damage 0
scoreboard players set #enemy test.status.crit_rate 0
scoreboard players set #enemy test.status.def 1000
scoreboard players set #enemy test.status.divergence 0
scoreboard players set #enemy test.status.effect_damage 0

# 本来はtest.status.hpとtest.status.hp_maxには実数値を設定
 scoreboard players operation #enemy test.status.hp = #dummy test.status.hp
 scoreboard players operation #enemy test.status.hp_max = #dummy test.status.hp

scoreboard players set #enemy test.status.exp 0
scoreboard players set #enemy test.status.magic_efficiency 0
scoreboard players set #enemy test.status.mp 0
scoreboard players set #enemy test.status.mp_max 0
scoreboard players set #enemy test.def.coefficient 1000
scoreboard players set #enemy test.def.debuff 0

scoreboard players set #enemy test.fire_resist 20
scoreboard players set #enemy test.water_resist 20
scoreboard players set #enemy test.wood_resist 20
scoreboard players set #enemy test.metal_resist 20
scoreboard players set #enemy test.earth_resist 20
scoreboard players set #enemy test.physics_resist 20

scoreboard players set #enemy test.fire_damage_inc.bonus 100
scoreboard players set #enemy test.water_damage_inc.bonus 100
scoreboard players set #enemy test.wood_damage_inc.bonus 100
scoreboard players set #enemy test.metal_damage_inc.bonus 100
scoreboard players set #enemy test.earth_damage_inc.bonus 100
scoreboard players set #enemy test.physics_damage_inc.bonus 100

scoreboard players set #enemy test.fire_damage.bonus 100
scoreboard players set #enemy test.water_damage.bonus 100
scoreboard players set #enemy test.wood_damage.bonus 100
scoreboard players set #enemy test.metal_damage.bonus 100
scoreboard players set #enemy test.earth_damage.bonus 100
scoreboard players set #enemy test.physics_damage.bonus 100

scoreboard players set #enemy test.fire_resist.pene 0
scoreboard players set #enemy test.water_resist.pene 0
scoreboard players set #enemy test.wood_resist.pene 0
scoreboard players set #enemy test.metal_resist.pene 0
scoreboard players set #enemy test.earth_resist.pene 0
scoreboard players set #enemy test.physics_resist.pene 0

scoreboard players set #enemy test.def.pene 0
