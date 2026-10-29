tag @s remove downed
scoreboard players set @s test.status.downed_timer 0
# ダウンしたときに付けた効果を外す(test:status/downed_start)
effect clear @s minecraft:blindness
effect clear @s minecraft:slowness
effect clear @s minecraft:weakness