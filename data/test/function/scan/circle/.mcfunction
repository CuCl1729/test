$execute as @e[tag=Axis,limit=1] at @s rotated $(Yaw) $(Pitch) run teleport @e[tag=Axis,sort=furthest,limit=1] ^ ^ ^1
execute as @e[tag=Axis] at @s facing entity @e[tag=Axis,sort=furthest,limit=1] feet run teleport @s ~ ~ ~ ~ ~

function test:scan/circle/main with storage test: circle
