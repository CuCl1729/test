execute as @n[tag=summoned,tag=station] at @s run function test:station/place
# 機械のエッグ(test:machine/give_egg)で置かれたマーカー。置いた人(@s)が研究で解放していない機械は、エッグを返して消える
function #oh_my_dat:please
execute as @n[tag=summoned,tag=machine] at @s run function test:machine/place_locked with entity @s data.machine
execute as @n[tag=summoned,tag=machine] at @s run function test:machine/place

advancement revoke @s only test:trigger/place
