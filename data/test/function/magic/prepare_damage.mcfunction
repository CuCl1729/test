#> test:magic/prepare_damage
# @s = 詠唱者。magic.player から属性ダメージ(@s test.<属性>_damage)を決める。
# 魔法の与ダメ補正(magic_damage_bonus)→ test:damage/pre_magic → 神秘(effect_damage)の順。
# リアルタイムの test:magic/ とターン制(test:battle/action/skill_cast/prepare_damage)の両方で使う

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
function test:status/refresh {status:"effect_damage"}

# effect_damageは1万分率(10000で×1)。属性ダメージに掛けてから10000で割ると、攻撃力が高いとき(剣を持ったまま
# 自動発動した魔法など)に2^31を超えて負になり、damage/apply_typeでカンストしていたので、先に100で割ってから掛ける
scoreboard players operation @s test.fire_damage /= #100 test.constant
scoreboard players operation @s test.fire_damage *= @s test.status.effect_damage
scoreboard players operation @s test.fire_damage /= #100 test.constant

scoreboard players operation @s test.water_damage /= #100 test.constant
scoreboard players operation @s test.water_damage *= @s test.status.effect_damage
scoreboard players operation @s test.water_damage /= #100 test.constant

scoreboard players operation @s test.wood_damage /= #100 test.constant
scoreboard players operation @s test.wood_damage *= @s test.status.effect_damage
scoreboard players operation @s test.wood_damage /= #100 test.constant

scoreboard players operation @s test.metal_damage /= #100 test.constant
scoreboard players operation @s test.metal_damage *= @s test.status.effect_damage
scoreboard players operation @s test.metal_damage /= #100 test.constant

scoreboard players operation @s test.earth_damage /= #100 test.constant
scoreboard players operation @s test.earth_damage *= @s test.status.effect_damage
scoreboard players operation @s test.earth_damage /= #100 test.constant
