scoreboard players operation #victim test.fire_damage = #damage test.fire_damage
scoreboard players operation #victim test.water_damage = #damage test.water_damage
scoreboard players operation #victim test.wood_damage = #damage test.wood_damage
scoreboard players operation #victim test.metal_damage = #damage test.metal_damage
scoreboard players operation #victim test.earth_damage = #damage test.earth_damage
scoreboard players operation #victim test.physics_damage = #damage test.physics_damage

execute if predicate test:damage/crit run function test:damage/crit

tellraw @a {score:{name:"#victim",objective:"test.physics_damage"}}

# 防御係数計算
 scoreboard players operation #victim test.status.def = @s test.status.def
 scoreboard players operation #victim test.temporary = @s test.status.def
 scoreboard players set #damage test.temporary 100
 scoreboard players operation #damage test.temporary -= #damage test.def.pene
 scoreboard players operation #damage test.temporary -= @s test.def.debuff
 scoreboard players operation #victim test.temporary *= #damage test.temporary
 scoreboard players operation #victim test.temporary /= #100 test.constant
 scoreboard players operation #victim test.temporary += @s test.def.coefficient
 scoreboard players operation #victim test.status.def *= #100 test.constant
 scoreboard players operation #victim test.status.def /= #victim test.temporary
 tellraw @a {score:{name:"#victim",objective:"test.status.def"}}
 tellraw @a {score:{name:"#victim",objective:"test.temporary"}}

# 炎属性ダメージ処理
 scoreboard players operation #victim test.fire_resist = @s test.fire_resist
 scoreboard players operation #victim test.fire_damage_inc.bonus = @s test.fire_damage_inc.bonus
 
 scoreboard players operation #victim test.fire_resist -= #100 test.constant
 scoreboard players operation #victim test.fire_resist *= #-1 test.constant
 scoreboard players operation #victim test.fire_resist += #damage test.fire_resist.pene
 scoreboard players operation #victim test.fire_resist += @s test.fire_resist.debuff
 scoreboard players operation #victim test.fire_damage *= #victim test.fire_resist
 scoreboard players operation #victim test.fire_damage /= #100 test.constant

 scoreboard players operation #victim test.fire_damage *= #victim test.fire_damage_inc.bonus
 scoreboard players operation #victim test.fire_damage /= #100 test.constant

 scoreboard players operation #victim test.fire_damage *= #victim test.status.def
 scoreboard players operation #victim test.fire_damage /= #100 test.constant

 execute if score #victim test.fire_damage matches ..-1 run scoreboard players set #victim test.fire_damage 2147483647

 scoreboard players operation @s test.status.hp -= #victim test.fire_damage

# 水属性ダメージ処理
 scoreboard players operation #victim test.water_resist = @s test.water_resist
 scoreboard players operation #victim test.water_damage_inc.bonus = @s test.water_damage_inc.bonus
 
 scoreboard players operation #victim test.water_resist -= #100 test.constant
 scoreboard players operation #victim test.water_resist *= #-1 test.constant
 scoreboard players operation #victim test.water_resist += #damage test.water_resist.pene
 scoreboard players operation #victim test.water_resist += @s test.water_resist.debuff
 scoreboard players operation #victim test.water_damage *= #victim test.water_resist
 scoreboard players operation #victim test.water_damage /= #100 test.constant

 scoreboard players operation #victim test.water_damage *= #victim test.water_damage_inc.bonus
 scoreboard players operation #victim test.water_damage /= #100 test.constant

 scoreboard players operation #victim test.water_damage *= #victim test.status.def
 scoreboard players operation #victim test.water_damage /= #100 test.constant

 execute if score #victim test.water_damage matches ..-1 run scoreboard players set #victim test.water_damage 2147483647

 scoreboard players operation @s test.status.hp -= #victim test.water_damage

# 自然属性ダメージ処理
 scoreboard players operation #victim test.wood_resist = @s test.wood_resist
 scoreboard players operation #victim test.wood_damage_inc.bonus = @s test.wood_damage_inc.bonus
 
 scoreboard players operation #victim test.wood_resist -= #100 test.constant
 scoreboard players operation #victim test.wood_resist *= #-1 test.constant
 scoreboard players operation #victim test.wood_resist += #damage test.wood_resist.pene
 scoreboard players operation #victim test.wood_resist += @s test.wood_resist.debuff
 scoreboard players operation #victim test.wood_damage *= #victim test.wood_resist
 scoreboard players operation #victim test.wood_damage /= #100 test.constant

 scoreboard players operation #victim test.wood_damage *= #victim test.wood_damage_inc.bonus
 scoreboard players operation #victim test.wood_damage /= #100 test.constant

 scoreboard players operation #victim test.wood_damage *= #victim test.status.def
 scoreboard players operation #victim test.wood_damage /= #100 test.constant

 execute if score #victim test.wood_damage matches ..-1 run scoreboard players set #victim test.wood_damage 2147483647

 scoreboard players operation @s test.status.hp -= #victim test.wood_damage

# 金属属性ダメージ処理
 scoreboard players operation #victim test.metal_resist = @s test.metal_resist
 scoreboard players operation #victim test.metal_damage_inc.bonus = @s test.metal_damage_inc.bonus
 
 scoreboard players operation #victim test.metal_resist -= #100 test.constant
 scoreboard players operation #victim test.metal_resist *= #-1 test.constant
 scoreboard players operation #victim test.metal_resist += #damage test.metal_resist.pene
 scoreboard players operation #victim test.metal_resist += @s test.metal_resist.debuff
 scoreboard players operation #victim test.metal_damage *= #victim test.metal_resist
 scoreboard players operation #victim test.metal_damage /= #100 test.constant

 scoreboard players operation #victim test.metal_damage *= #victim test.metal_damage_inc.bonus
 scoreboard players operation #victim test.metal_damage /= #100 test.constant
 
 scoreboard players operation #victim test.metal_damage *= #victim test.status.def
 scoreboard players operation #victim test.metal_damage /= #100 test.constant

 execute if score #victim test.metal_damage matches ..-1 run scoreboard players set #victim test.metal_damage 2147483647

 scoreboard players operation @s test.status.hp -= #victim test.metal_damage

# 地属性ダメージ処理
 scoreboard players operation #victim test.earth_resist = @s test.earth_resist
 scoreboard players operation #victim test.earth_damage_inc.bonus = @s test.earth_damage_inc.bonus
 
 scoreboard players operation #victim test.earth_resist -= #100 test.constant
 scoreboard players operation #victim test.earth_resist *= #-1 test.constant
 scoreboard players operation #victim test.earth_resist += #damage test.earth_resist.pene
 scoreboard players operation #victim test.earth_resist += @s test.earth_resist.debuff
 scoreboard players operation #victim test.earth_damage *= #victim test.earth_resist
 scoreboard players operation #victim test.earth_damage /= #100 test.constant

 scoreboard players operation #victim test.earth_damage *= #victim test.earth_damage_inc.bonus
 scoreboard players operation #victim test.earth_damage /= #100 test.constant
 
 scoreboard players operation #victim test.earth_damage *= #victim test.status.def
 scoreboard players operation #victim test.earth_damage /= #100 test.constant
 
 execute if score #victim test.earth_damage matches ..-1 run scoreboard players set #victim test.earth_damage 2147483647

 scoreboard players operation @s test.status.hp -= #victim test.earth_damage

# 物理ダメージ処理
 scoreboard players operation #victim test.physics_resist = @s test.physics_resist
 scoreboard players operation #victim test.physics_damage_inc.bonus = @s test.physics_damage_inc.bonus
 
 scoreboard players operation #victim test.physics_resist -= #100 test.constant
 scoreboard players operation #victim test.physics_resist *= #-1 test.constant
 scoreboard players operation #victim test.physics_resist += #damage test.physics_resist.pene
 scoreboard players operation #victim test.physics_resist += @s test.physics_resist.debuff
 scoreboard players operation #victim test.physics_damage *= #victim test.physics_resist
 scoreboard players operation #victim test.physics_damage /= #100 test.constant

 scoreboard players operation #victim test.physics_damage *= #victim test.physics_damage_inc.bonus
 scoreboard players operation #victim test.physics_damage /= #100 test.constant
 
 scoreboard players operation #victim test.physics_damage *= #victim test.status.def
 scoreboard players operation #victim test.physics_damage /= #100 test.constant

 execute if score #victim test.physics_damage matches ..-1 run scoreboard players set #victim test.physics_damage 2147483647

 scoreboard players operation @s test.status.hp -= #victim test.physics_damage

tellraw @a ["",\
{score:{name:"#victim",objective:"test.physics_damage"},color:"white"},\
{score:{name:"#victim",objective:"test.fire_damage"},color:red},\
{score:{name:"#victim",objective:"test.water_damage"},color:aqua},\
{score:{name:"#victim",objective:"test.wood_damage"},color:"green"},\
{score:{name:"#victim",objective:"test.metal_damage"},color:"yellow"},\
{score:{name:"#victim",objective:"test.earth_damage"},color:"#9b5d00"}]
execute if score @s test.status.hp matches ..0 run function test:damage/kill
