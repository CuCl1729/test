execute as @n[tag=summoned,tag=station] at @s run function test:station/place
# 機械のエッグ(test:machine/give_egg)で置かれたマーカー
execute as @n[tag=summoned,tag=machine] at @s run function test:machine/place

advancement revoke @s only test:trigger/place