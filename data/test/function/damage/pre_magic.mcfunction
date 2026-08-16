# ターン制バトルのアイテム式UIでは行動アイテム選択でメインハンドが一時的に入れ替わるため、
# ここで再計算すると武器補正が失われる。その場合はtest:battle/ui/itemで配布前に計算済みの値を使う。
execute unless score @s test.battle.id matches 1.. run function test:status/update {status:"atk"}
execute unless score @s test.battle.id matches 1.. run function test:status/update {status:"hp_max"}
execute unless score @s test.battle.id matches 1.. run function test:status/update {status:"def"}
execute if score @s test.battle.id matches 1.. if score @s test.settings.battle_ui matches 1 run function test:status/update {status:"atk"}
execute if score @s test.battle.id matches 1.. if score @s test.settings.battle_ui matches 1 run function test:status/update {status:"hp_max"}
execute if score @s test.battle.id matches 1.. if score @s test.settings.battle_ui matches 1 run function test:status/update {status:"def"}

scoreboard players reset @s test.fire_damage
scoreboard players reset @s test.water_damage
scoreboard players reset @s test.wood_damage
scoreboard players reset @s test.metal_damage
scoreboard players reset @s test.earth_damage
scoreboard players reset @s test.physics_damage

execute store result score #multiplier test.temporary run data get storage test: magic.player.data.magic.fire.atk
scoreboard players operation #damage test.fire_damage = @s test.status.atk
scoreboard players operation #damage test.fire_damage *= #multiplier test.temporary
scoreboard players operation #damage test.fire_damage /= #100 test.constant


execute store result score #multiplier test.temporary run data get storage test: magic.player.data.magic.fire.hp_max
scoreboard players operation #damage test.temporary = @s test.status.hp_max
scoreboard players operation #damage test.temporary *= #multiplier test.temporary
scoreboard players operation #damage test.temporary /= #100 test.constant
scoreboard players operation #damage test.fire_damage += #damage test.temporary

execute store result score #multiplier test.temporary run data get storage test: magic.player.data.magic.fire.def
scoreboard players operation #damage test.temporary = @s test.status.def
scoreboard players operation #damage test.temporary *= #multiplier test.temporary
scoreboard players operation #damage test.temporary /= #100 test.constant
scoreboard players operation #damage test.fire_damage += #damage test.temporary

execute store result score #damage test.temporary run data get storage test: magic.player.data.magic.fire.base
scoreboard players operation #damage test.fire_damage += #damage test.temporary

scoreboard players operation @s test.fire_damage = #damage test.fire_damage

execute store result score #multiplier test.temporary run data get storage test: magic.player.data.magic.water.atk
scoreboard players operation #damage test.water_damage = @s test.status.atk
scoreboard players operation #damage test.water_damage *= #multiplier test.temporary
scoreboard players operation #damage test.water_damage /= #100 test.constant

execute store result score #multiplier test.temporary run data get storage test: magic.player.data.magic.water.hp_max
scoreboard players operation #damage test.temporary = @s test.status.hp_max
scoreboard players operation #damage test.temporary *= #multiplier test.temporary
scoreboard players operation #damage test.temporary /= #100 test.constant
scoreboard players operation #damage test.water_damage += #damage test.temporary

execute store result score #multiplier test.temporary run data get storage test: magic.player.data.magic.water.def
scoreboard players operation #damage test.temporary = @s test.status.def
scoreboard players operation #damage test.temporary *= #multiplier test.temporary
scoreboard players operation #damage test.temporary /= #100 test.constant
scoreboard players operation #damage test.water_damage += #damage test.temporary

execute store result score #damage test.temporary run data get storage test: magic.player.data.magic.water.base
scoreboard players operation #damage test.water_damage += #damage test.temporary

scoreboard players operation @s test.water_damage = #damage test.water_damage

execute store result score #multiplier test.temporary run data get storage test: magic.player.data.magic.wood.atk
scoreboard players operation #damage test.wood_damage = @s test.status.atk
scoreboard players operation #damage test.wood_damage *= #multiplier test.temporary
scoreboard players operation #damage test.wood_damage /= #100 test.constant

execute store result score #multiplier test.temporary run data get storage test: magic.player.data.magic.wood.hp_max
scoreboard players operation #damage test.temporary = @s test.status.hp_max
scoreboard players operation #damage test.temporary *= #multiplier test.temporary
scoreboard players operation #damage test.temporary /= #100 test.constant
scoreboard players operation #damage test.wood_damage += #damage test.temporary

execute store result score #multiplier test.temporary run data get storage test: magic.player.data.magic.wood.def
scoreboard players operation #damage test.temporary = @s test.status.def
scoreboard players operation #damage test.temporary *= #multiplier test.temporary
scoreboard players operation #damage test.temporary /= #100 test.constant
scoreboard players operation #damage test.wood_damage += #damage test.temporary

execute store result score #damage test.temporary run data get storage test: magic.player.data.magic.wood.base
scoreboard players operation #damage test.wood_damage += #damage test.temporary

scoreboard players operation @s test.wood_damage = #damage test.wood_damage

execute store result score #multiplier test.temporary run data get storage test: magic.player.data.magic.metal.atk
scoreboard players operation #damage test.metal_damage = @s test.status.atk
scoreboard players operation #damage test.metal_damage *= #multiplier test.temporary
scoreboard players operation #damage test.metal_damage /= #100 test.constant

execute store result score #multiplier test.temporary run data get storage test: magic.player.data.magic.metal.hp_max
scoreboard players operation #damage test.temporary = @s test.status.hp_max
scoreboard players operation #damage test.temporary *= #multiplier test.temporary
scoreboard players operation #damage test.temporary /= #100 test.constant
scoreboard players operation #damage test.metal_damage += #damage test.temporary

execute store result score #multiplier test.temporary run data get storage test: magic.player.data.magic.metal.def
scoreboard players operation #damage test.temporary = @s test.status.def
scoreboard players operation #damage test.temporary *= #multiplier test.temporary
scoreboard players operation #damage test.temporary /= #100 test.constant
scoreboard players operation #damage test.metal_damage += #damage test.temporary

execute store result score #damage test.temporary run data get storage test: magic.player.data.magic.metal.base
scoreboard players operation #damage test.metal_damage += #damage test.temporary

scoreboard players operation @s test.metal_damage = #damage test.metal_damage

execute store result score #multiplier test.temporary run data get storage test: magic.player.data.magic.earth.atk
scoreboard players operation #damage test.earth_damage = @s test.status.atk
scoreboard players operation #damage test.earth_damage *= #multiplier test.temporary
scoreboard players operation #damage test.earth_damage /= #100 test.constant

execute store result score #multiplier test.temporary run data get storage test: magic.player.data.magic.earth.hp_max
scoreboard players operation #damage test.temporary = @s test.status.hp_max
scoreboard players operation #damage test.temporary *= #multiplier test.temporary
scoreboard players operation #damage test.temporary /= #100 test.constant
scoreboard players operation #damage test.earth_damage += #damage test.temporary

execute store result score #multiplier test.temporary run data get storage test: magic.player.data.magic.earth.def
scoreboard players operation #damage test.temporary = @s test.status.def
scoreboard players operation #damage test.temporary *= #multiplier test.temporary
scoreboard players operation #damage test.temporary /= #100 test.constant
scoreboard players operation #damage test.earth_damage += #damage test.temporary

execute store result score #damage test.temporary run data get storage test: magic.player.data.magic.earth.base
scoreboard players operation #damage test.earth_damage += #damage test.temporary

scoreboard players operation @s test.earth_damage = #damage test.earth_damage

scoreboard players operation @s test.fire_damage *= @s test.fire_damage.bonus
scoreboard players operation @s test.fire_damage /= #100 test.constant

scoreboard players operation @s test.water_damage *= @s test.water_damage.bonus
scoreboard players operation @s test.water_damage /= #100 test.constant

scoreboard players operation @s test.wood_damage *= @s test.wood_damage.bonus
scoreboard players operation @s test.wood_damage /= #100 test.constant

scoreboard players operation @s test.metal_damage *= @s test.metal_damage.bonus
scoreboard players operation @s test.metal_damage /= #100 test.constant

scoreboard players operation @s test.earth_damage *= @s test.earth_damage.bonus
scoreboard players operation @s test.earth_damage /= #100 test.constant
