#> test:battle/action/attack_damage_enemy
# @s = 攻撃する敵。攻撃力をそのまま物理ダメージとして #damage に載せる

scoreboard players set #damage test.fire_damage 0
scoreboard players set #damage test.water_damage 0
scoreboard players set #damage test.wood_damage 0
scoreboard players set #damage test.metal_damage 0
scoreboard players set #damage test.earth_damage 0

scoreboard players operation #damage test.physics_damage = @s test.status.atk
scoreboard players operation #damage test.physics_damage *= @s test.physics_damage.bonus
scoreboard players operation #damage test.physics_damage /= #100 test.constant

scoreboard players set #damage test.def.pene 0
scoreboard players operation #damage test.def.pene = @s test.def.pene
scoreboard players set #damage test.physics_resist.pene 0
scoreboard players operation #damage test.physics_resist.pene = @s test.physics_resist.pene

scoreboard players operation #damage test.status.crit_rate = @s test.status.crit_rate
scoreboard players operation #damage test.status.crit_damage = @s test.status.crit_damage
scoreboard players operation #damage test.status.crit_damage /= #100 test.constant
