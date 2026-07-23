$execute as @e[tag=Axis,limit=1] at @s rotated $(Yaw) $(Pitch) run summon armor_stand ^ ^ ^1 {Tags:[Axis,temp],Marker:1b}
execute as @e[tag=Axis] at @s facing entity @e[tag=Axis,sort=furthest,limit=1] feet run teleport @s ~ ~ ~ ~ ~

function test:scan/circle/main with storage test: circle

kill @e[tag=temp]