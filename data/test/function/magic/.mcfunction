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

# 防具のセット効果(magic_cast)。ダメージが決まった後、届け方へ渡す前に詠唱者の属性ダメージをいじれる
function test:equip/event {event:"magic_cast"}

# タイプを増やしてもここを触らずに済むよう、magic/<id>/cast へマクロで委譲する
function test:magic/dispatch with storage test: magic.player