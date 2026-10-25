#> test:equip/apply_resist
# @s = プレイヤー。装備の属性耐性(×100)を、被ダメージ計算が読む test.<属性>_resist(%)へ入れる

scoreboard players operation @s test.fire_resist = @s test.equip.fire_resist_add
scoreboard players operation @s test.fire_resist /= #100 test.constant
scoreboard players operation @s test.water_resist = @s test.equip.water_resist_add
scoreboard players operation @s test.water_resist /= #100 test.constant
scoreboard players operation @s test.wood_resist = @s test.equip.wood_resist_add
scoreboard players operation @s test.wood_resist /= #100 test.constant
scoreboard players operation @s test.metal_resist = @s test.equip.metal_resist_add
scoreboard players operation @s test.metal_resist /= #100 test.constant
scoreboard players operation @s test.earth_resist = @s test.equip.earth_resist_add
scoreboard players operation @s test.earth_resist /= #100 test.constant
scoreboard players operation @s test.physics_resist = @s test.equip.physics_resist_add
scoreboard players operation @s test.physics_resist /= #100 test.constant
