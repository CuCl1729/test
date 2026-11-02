execute as @n[tag=summoned,tag=station] at @s run function test:station/place
# 機械のエッグ(test:machine/give_egg)で置かれたマーカー。置いた人(@s)が研究で解放していない機械は、エッグを返して消える
function #oh_my_dat:please
execute as @n[tag=summoned,tag=machine] at @s run function test:machine/place_locked with entity @s data.machine
execute as @n[tag=summoned,tag=machine] at @s run function test:machine/place
# 鉱脈・採取ポイントのエッグ(test:mine/egg/give / test:gather/egg/give)。@s(置いた人)のまま、出たアマスタの位置で置く
execute at @n[type=armor_stand,tag=summoned,tag=vein_egg] run function test:mine/egg/place with entity @n[type=armor_stand,tag=summoned,tag=vein_egg] data
execute at @n[type=armor_stand,tag=summoned,tag=gather_egg] run function test:gather/egg/place with entity @n[type=armor_stand,tag=summoned,tag=gather_egg] data

advancement revoke @s only test:trigger/place
