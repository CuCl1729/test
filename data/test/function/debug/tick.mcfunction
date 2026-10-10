execute if score #debug test.debug.enabled matches 1 in test:arena as @e[tag=battle_marker,limit=1,sort=nearest] run function test:debug/update_display
execute if score #debug test.debug.enabled matches 1 if data storage test: debug.watch[0] run function test:debug/watch/tick
