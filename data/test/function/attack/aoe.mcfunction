#> test:attack/aoe
# @s = プレイヤー。右クリックで発動する扇状(コーン)の範囲攻撃。武器の装備値は通常攻撃と共通の
# test:attack/prepareで計算し、範囲攻撃専用の倍率(weapon.aoe_multiplier)だけ追加で掛ける

function test:attack/prepare

execute store result score #aoe_multiplier test.temporary run data get storage test: attack.player.weapon[{type:"aoe_multiplier"}].value
scoreboard players operation #damage test.fire_damage *= #aoe_multiplier test.temporary
scoreboard players operation #damage test.fire_damage /= #100 test.constant
scoreboard players operation #damage test.water_damage *= #aoe_multiplier test.temporary
scoreboard players operation #damage test.water_damage /= #100 test.constant
scoreboard players operation #damage test.wood_damage *= #aoe_multiplier test.temporary
scoreboard players operation #damage test.wood_damage /= #100 test.constant
scoreboard players operation #damage test.metal_damage *= #aoe_multiplier test.temporary
scoreboard players operation #damage test.metal_damage /= #100 test.constant
scoreboard players operation #damage test.earth_damage *= #aoe_multiplier test.temporary
scoreboard players operation #damage test.earth_damage /= #100 test.constant
scoreboard players operation #damage test.physics_damage *= #aoe_multiplier test.temporary
scoreboard players operation #damage test.physics_damage /= #100 test.constant

# コーンの半角と、扇の奥行き(=歩数、既にtest.repeatにreachとして入っている)を保持しておく
execute store result score #aoe_half_angle test.temporary run data get storage test: attack.player.weapon[{type:"aoe_angle"}].value
scoreboard players operation #aoe_half_angle test.temporary /= #2 test.constant
scoreboard players operation #aoe_reach test.temporary = @s test.repeat

execute anchored eyes positioned ^ ^ ^0.5 run function test:scan/aoe/
