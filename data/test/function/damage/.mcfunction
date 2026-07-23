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

# 属性ごとのダメージ処理
function test:damage/apply_type {type:"fire"}
function test:damage/apply_type {type:"water"}
function test:damage/apply_type {type:"wood"}
function test:damage/apply_type {type:"metal"}
function test:damage/apply_type {type:"earth"}
function test:damage/apply_type {type:"physics"}

tellraw @a ["",\
{score:{name:"#victim",objective:"test.physics_damage"},color:"white"},\
{score:{name:"#victim",objective:"test.fire_damage"},color:red},\
{score:{name:"#victim",objective:"test.water_damage"},color:aqua},\
{score:{name:"#victim",objective:"test.wood_damage"},color:"green"},\
{score:{name:"#victim",objective:"test.metal_damage"},color:"yellow"},\
{score:{name:"#victim",objective:"test.earth_damage"},color:"#9b5d00"}]
execute if score @s test.status.hp matches ..0 run function test:damage/kill