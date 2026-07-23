function test:status/update {status:"atk"}
function test:status/update {status:"hp_max"}
function test:status/update {status:"def"}

scoreboard players reset @s test.fire_damage
scoreboard players reset @s test.water_damage
scoreboard players reset @s test.wood_damage
scoreboard players reset @s test.metal_damage
scoreboard players reset @s test.earth_damage
scoreboard players reset @s test.physics_damage

# 炎属性ダメージ処理
 execute store result score #multiplier test.temporary run data get storage test: attack.player.damage.fire.atk
 scoreboard players operation #damage test.fire_damage = @s test.status.atk
 scoreboard players operation #damage test.fire_damage *= #multiplier test.temporary
 scoreboard players operation #damage test.fire_damage /= #100 test.constant
 
 execute store result score #multiplier test.temporary run data get storage test: attack.player.damage.fire.hp_max
 scoreboard players operation #damage test.temporary = @s test.status.hp_max
 scoreboard players operation #damage test.temporary *= #multiplier test.temporary
 scoreboard players operation #damage test.temporary /= #100 test.constant
 scoreboard players operation #damage test.fire_damage += #damage test.temporary
 
 execute store result score #multiplier test.temporary run data get storage test: attack.player.damage.fire.def
 scoreboard players operation #damage test.temporary = @s test.status.def
 scoreboard players operation #damage test.temporary *= #multiplier test.temporary
 scoreboard players operation #damage test.temporary /= #100 test.constant
 scoreboard players operation #damage test.fire_damage += #damage test.temporary
 
 execute store result score #damage test.temporary run data get storage test: attack.player.damage.fire.base
 scoreboard players operation #damage test.fire_damage += #damage test.temporary
 
 scoreboard players operation @s test.fire_damage = #damage test.fire_damage

# 水属性ダメージ処理
 execute store result score #multiplier test.temporary run data get storage test: attack.player.damage.water.atk
 scoreboard players operation #damage test.water_damage = @s test.status.atk
 scoreboard players operation #damage test.water_damage *= #multiplier test.temporary
 scoreboard players operation #damage test.water_damage /= #100 test.constant
 
 execute store result score #multiplier test.temporary run data get storage test: attack.player.damage.water.hp_max
 scoreboard players operation #damage test.temporary = @s test.status.hp_max
 scoreboard players operation #damage test.temporary *= #multiplier test.temporary
 scoreboard players operation #damage test.temporary /= #100 test.constant
 scoreboard players operation #damage test.water_damage += #damage test.temporary
 
 execute store result score #multiplier test.temporary run data get storage test: attack.player.damage.water.def
 scoreboard players operation #damage test.temporary = @s test.status.def
 scoreboard players operation #damage test.temporary *= #multiplier test.temporary
 scoreboard players operation #damage test.temporary /= #100 test.constant
 scoreboard players operation #damage test.water_damage += #damage test.temporary
 
 execute store result score #damage test.temporary run data get storage test: attack.player.damage.water.base
 scoreboard players operation #damage test.water_damage += #damage test.temporary
 
 scoreboard players operation @s test.water_damage = #damage test.water_damage

# 自然属性ダメージ
 execute store result score #multiplier test.temporary run data get storage test: attack.player.damage.wood.atk
 scoreboard players operation #damage test.wood_damage = @s test.status.atk
 scoreboard players operation #damage test.wood_damage *= #multiplier test.temporary
 scoreboard players operation #damage test.wood_damage /= #100 test.constant
 
 execute store result score #multiplier test.temporary run data get storage test: attack.player.damage.wood.hp_max
 scoreboard players operation #damage test.temporary = @s test.status.hp_max
 scoreboard players operation #damage test.temporary *= #multiplier test.temporary
 scoreboard players operation #damage test.temporary /= #100 test.constant
 scoreboard players operation #damage test.wood_damage += #damage test.temporary
 
 execute store result score #multiplier test.temporary run data get storage test: attack.player.damage.wood.def
 scoreboard players operation #damage test.temporary = @s test.status.def
 scoreboard players operation #damage test.temporary *= #multiplier test.temporary
 scoreboard players operation #damage test.temporary /= #100 test.constant
 scoreboard players operation #damage test.wood_damage += #damage test.temporary
 
 execute store result score #damage test.temporary run data get storage test: attack.player.damage.wood.base
 scoreboard players operation #damage test.wood_damage += #damage test.temporary
 
 scoreboard players operation @s test.wood_damage = #damage test.wood_damage

# 金属属性ダメージ処理
 execute store result score #multiplier test.temporary run data get storage test: attack.player.damage.metal.atk
 scoreboard players operation #damage test.metal_damage = @s test.status.atk
 scoreboard players operation #damage test.metal_damage *= #multiplier test.temporary
 scoreboard players operation #damage test.metal_damage /= #100 test.constant
 
 execute store result score #multiplier test.temporary run data get storage test: attack.player.damage.metal.hp_max
 scoreboard players operation #damage test.temporary = @s test.status.hp_max
 scoreboard players operation #damage test.temporary *= #multiplier test.temporary
 scoreboard players operation #damage test.temporary /= #100 test.constant
 scoreboard players operation #damage test.metal_damage += #damage test.temporary
 
 execute store result score #multiplier test.temporary run data get storage test: attack.player.damage.metal.def
 scoreboard players operation #damage test.temporary = @s test.status.def
 scoreboard players operation #damage test.temporary *= #multiplier test.temporary
 scoreboard players operation #damage test.temporary /= #100 test.constant
 scoreboard players operation #damage test.metal_damage += #damage test.temporary
 
 execute store result score #damage test.temporary run data get storage test: attack.player.damage.metal.base
 scoreboard players operation #damage test.metal_damage += #damage test.temporary

scoreboard players operation @s test.metal_damage = #damage test.metal_damage

# 地属性ダメージ
 execute store result score #multiplier test.temporary run data get storage test: attack.player.damage.earth.atk
 scoreboard players operation #damage test.earth_damage = @s test.status.atk
 scoreboard players operation #damage test.earth_damage *= #multiplier test.temporary
 scoreboard players operation #damage test.earth_damage /= #100 test.constant
 
 execute store result score #multiplier test.temporary run data get storage test: attack.player.damage.earth.hp_max
 scoreboard players operation #damage test.temporary = @s test.status.hp_max
 scoreboard players operation #damage test.temporary *= #multiplier test.temporary
 scoreboard players operation #damage test.temporary /= #100 test.constant
 scoreboard players operation #damage test.earth_damage += #damage test.temporary
 
 execute store result score #multiplier test.temporary run data get storage test: attack.player.damage.earth.def
 scoreboard players operation #damage test.temporary = @s test.status.def
 scoreboard players operation #damage test.temporary *= #multiplier test.temporary
 scoreboard players operation #damage test.temporary /= #100 test.constant
 scoreboard players operation #damage test.earth_damage += #damage test.temporary
 
 execute store result score #damage test.temporary run data get storage test: attack.player.damage.earth.base
 scoreboard players operation #damage test.earth_damage += #damage test.temporary
 
 scoreboard players operation @s test.earth_damage = #damage test.earth_damage

# 物理ダメージ処理
 execute store result score #multiplier test.temporary run data get storage test: attack.player.damage.physics.atk
 scoreboard players operation #damage test.physics_damage = @s test.status.atk
 scoreboard players operation #damage test.physics_damage *= #multiplier test.temporary
 scoreboard players operation #damage test.physics_damage /= #100 test.constant
 
 execute store result score #multiplier test.temporary run data get storage test: attack.player.damage.physics.hp_max
 scoreboard players operation #damage test.temporary = @s test.status.hp_max
 scoreboard players operation #damage test.temporary *= #multiplier test.temporary
 scoreboard players operation #damage test.temporary /= #100 test.constant
 scoreboard players operation #damage test.physics_damage += #damage test.temporary
 
 execute store result score #multiplier test.temporary run data get storage test: attack.player.damage.physics.def
 scoreboard players operation #damage test.temporary = @s test.status.def
 scoreboard players operation #damage test.temporary *= #multiplier test.temporary
 scoreboard players operation #damage test.temporary /= #100 test.constant
 scoreboard players operation #damage test.physics_damage += #damage test.temporary
 
 execute store result score #damage test.temporary run data get storage test: attack.player.damage.physics.base
 scoreboard players operation #damage test.physics_damage += #damage test.temporary
 
 scoreboard players operation @s test.physics_damage = #damage test.physics_damage

# 与ダメ処理
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

 scoreboard players operation @s test.physics_damage *= @s test.physics_damage.bonus
 scoreboard players operation @s test.physics_damage /= #100 test.constant
