execute unless score @s test.repeat matches 0.. store result score #heal test.temporary run data get storage test: magic.player.heal.power

scoreboard players operation @s test.status.hp_regene *= @s test.status.effect_damage
scoreboard players operation @s test.status.hp_regene /= #10000 test.constant
function test:status/regene/hp
scoreboard players operation @s test.status.hp_regene *= #10000 test.constant
scoreboard players operation @s test.status.hp_regene /= @s test.status.effect_damage
scoreboard players add @s test.repeat 1

execute if score @s test.repeat <= #heal test.temporary run function test:magic/effect/heal
