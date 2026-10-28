
scoreboard players set @s test.fire_damage.bonus 100
scoreboard players set @s test.water_damage.bonus 100
scoreboard players set @s test.wood_damage.bonus 100
scoreboard players set @s test.metal_damage.bonus 100
scoreboard players set @s test.earth_damage.bonus 100
scoreboard players set @s test.physics_damage.bonus 100

scoreboard players set @s test.fire_resist.pene 0
scoreboard players set @s test.water_resist.pene 0
scoreboard players set @s test.wood_resist.pene 0
scoreboard players set @s test.metal_resist.pene 0
scoreboard players set @s test.earth_resist.pene 0
scoreboard players set @s test.physics_resist.pene 0

scoreboard players set @s test.def.pene 0

function test:init/asset/status/defense

scoreboard players set @s test.multi_shot 1

# 初期の能力値はスプレッドシートの「プレイヤー初期値」タブから生成している(tools/datasheet/generate.ps1)
function test:init/asset/status/generated/base

