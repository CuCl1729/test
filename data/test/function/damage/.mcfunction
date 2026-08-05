scoreboard players operation #victim test.fire_damage = #damage test.fire_damage
scoreboard players operation #victim test.water_damage = #damage test.water_damage
scoreboard players operation #victim test.wood_damage = #damage test.wood_damage
scoreboard players operation #victim test.metal_damage = #damage test.metal_damage
scoreboard players operation #victim test.earth_damage = #damage test.earth_damage
scoreboard players operation #victim test.physics_damage = #damage test.physics_damage

execute if predicate test:damage/crit run function test:damage/crit

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

# 属性ごとのダメージ処理
function test:damage/apply_type {type:"fire"}
function test:damage/apply_type {type:"water"}
function test:damage/apply_type {type:"wood"}
function test:damage/apply_type {type:"metal"}
function test:damage/apply_type {type:"earth"}
function test:damage/apply_type {type:"physics"}

execute if score @s test.status.hp matches ..0 run function test:damage/kill