execute unless score @s test.status.hp_max matches 1.. run function test:init/player

function test:status/level_up

function test:status/regene/hp
function test:status/regene/mp

scoreboard players operation @s test.status.burnout -= @s test.status.divergence

execute if score @s test.status.burnout matches ..-1 run scoreboard players set @s test.status.burnout 0

advancement revoke @s only test:status/regene