tag @s[type=!player] add kill

execute if entity @s[type=player,tag=!downed] if dimension test:action run function test:status/downed_start