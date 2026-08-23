#> test:battle/action/skill_cast/prepare_damage
# @s = 詠唱者。組み立て済みのmagic.playerから魔法ダメージを計算し、#damage系スコアへ載せる
# (投射・範囲どちらの詠唱でも使う共通処理)

function test:damage/pre_magic

scoreboard players set #damage test.physics_damage 0
scoreboard players operation #damage test.fire_damage = @s test.fire_damage
scoreboard players operation #damage test.water_damage = @s test.water_damage
scoreboard players operation #damage test.wood_damage = @s test.wood_damage
scoreboard players operation #damage test.metal_damage = @s test.metal_damage
scoreboard players operation #damage test.earth_damage = @s test.earth_damage

scoreboard players set #damage test.def.pene 0
scoreboard players operation #damage test.def.pene = @s test.def.pene
scoreboard players set #damage test.fire_resist.pene 0
scoreboard players operation #damage test.fire_resist.pene = @s test.fire_resist.pene
scoreboard players set #damage test.water_resist.pene 0
scoreboard players operation #damage test.water_resist.pene = @s test.water_resist.pene
scoreboard players set #damage test.wood_resist.pene 0
scoreboard players operation #damage test.wood_resist.pene = @s test.wood_resist.pene
scoreboard players set #damage test.metal_resist.pene 0
scoreboard players operation #damage test.metal_resist.pene = @s test.metal_resist.pene
scoreboard players set #damage test.earth_resist.pene 0
scoreboard players operation #damage test.earth_resist.pene = @s test.earth_resist.pene

scoreboard players operation #damage test.status.crit_rate = @s test.status.crit_rate
scoreboard players operation #damage test.status.crit_damage = @s test.status.crit_damage
scoreboard players operation #damage test.status.crit_damage /= #100 test.constant
