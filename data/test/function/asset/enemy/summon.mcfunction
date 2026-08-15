$summon $(id) ~ ~ ~ {Tags:[summoned],Invulnerable:1b}


data modify entity @n[tag=summoned] Tags append from storage test: enemy.Tags[]
data modify entity @n[tag=summoned] data set from storage test: enemy.data

scoreboard players operation @n[tag=summoned] test.status.atk = #enemy test.status.atk
scoreboard players operation @n[tag=summoned] test.status.crit_damage = #enemy test.status.crit_damage
scoreboard players operation @n[tag=summoned] test.status.crit_rate = #enemy test.status.crit_rate
scoreboard players operation @n[tag=summoned] test.status.def = #enemy test.status.def
scoreboard players operation @n[tag=summoned] test.status.divergence = #enemy test.status.divergence
scoreboard players operation @n[tag=summoned] test.status.effect_damage = #enemy test.status.effect_damage
scoreboard players operation @n[tag=summoned] test.status.hp_max = #enemy test.status.hp_max
scoreboard players operation @n[tag=summoned] test.status.hp = #enemy test.status.hp
scoreboard players operation @n[tag=summoned] test.status.magic_efficiency = #enemy test.status.magic_efficiency
scoreboard players operation @n[tag=summoned] test.status.mp_max = #enemy test.status.mp_max
scoreboard players operation @n[tag=summoned] test.status.mp = #enemy test.status.mp
scoreboard players operation @n[tag=summoned] test.status.exp = #enemy test.status.exp
scoreboard players operation @n[tag=summoned] test.def.debuff = #enemy test.def.debuff
scoreboard players operation @n[tag=summoned] test.def.coefficient = #enemy test.def.coefficient
scoreboard players operation @n[tag=summoned] test.def.pene = #enemy test.def.pene

scoreboard players operation @n[tag=summoned] test.fire_resist = #enemy test.fire_resist
scoreboard players operation @n[tag=summoned] test.water_resist = #enemy test.water_resist
scoreboard players operation @n[tag=summoned] test.wood_resist = #enemy test.wood_resist
scoreboard players operation @n[tag=summoned] test.metal_resist = #enemy test.metal_resist
scoreboard players operation @n[tag=summoned] test.earth_resist = #enemy test.earth_resist
scoreboard players operation @n[tag=summoned] test.physics_resist = #enemy test.physics_resist

scoreboard players operation @n[tag=summoned] test.fire_damage_inc.bonus = #enemy test.fire_damage_inc.bonus
scoreboard players operation @n[tag=summoned] test.water_damage_inc.bonus = #enemy test.water_damage_inc.bonus
scoreboard players operation @n[tag=summoned] test.wood_damage_inc.bonus = #enemy test.wood_damage_inc.bonus
scoreboard players operation @n[tag=summoned] test.metal_damage_inc.bonus = #enemy test.metal_damage_inc.bonus
scoreboard players operation @n[tag=summoned] test.earth_damage_inc.bonus = #enemy test.earth_damage_inc.bonus
scoreboard players operation @n[tag=summoned] test.physics_damage_inc.bonus = #enemy test.physics_damage_inc.bonus

scoreboard players operation @n[tag=summoned] test.fire_damage.bonus = #enemy test.fire_damage.bonus
scoreboard players operation @n[tag=summoned] test.water_damage.bonus = #enemy test.water_damage.bonus
scoreboard players operation @n[tag=summoned] test.wood_damage.bonus = #enemy test.wood_damage.bonus
scoreboard players operation @n[tag=summoned] test.metal_damage.bonus = #enemy test.metal_damage.bonus
scoreboard players operation @n[tag=summoned] test.earth_damage.bonus = #enemy test.earth_damage.bonus
scoreboard players operation @n[tag=summoned] test.physics_damage.bonus = #enemy test.physics_damage.bonus

scoreboard players operation @n[tag=summoned] test.fire_resist.pene = #enemy test.fire_resist.pene
scoreboard players operation @n[tag=summoned] test.water_resist.pene = #enemy test.water_resist.pene
scoreboard players operation @n[tag=summoned] test.wood_resist.pene = #enemy test.wood_resist.pene
scoreboard players operation @n[tag=summoned] test.metal_resist.pene = #enemy test.metal_resist.pene
scoreboard players operation @n[tag=summoned] test.earth_resist.pene = #enemy test.earth_resist.pene
scoreboard players operation @n[tag=summoned] test.physics_resist.pene = #enemy test.physics_resist.pene

tag @n[tag=summoned] add enemy
tag @e[tag=summoned] remove summoned