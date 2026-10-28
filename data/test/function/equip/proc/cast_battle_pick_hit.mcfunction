#> test:equip/proc/cast_battle_pick_hit
# @s = 唱えるプレイヤー(at @s)。当たった敵(equip_proc_target)のうち、同じ戦闘で生きている1体に battle_target を付ける

execute as @e[tag=equip_proc_target,tag=enemy,distance=..64,scores={test.status.hp=1..},sort=nearest] if score @s test.battle.id = #proc_cast_battle test.battle.id run return run tag @s add battle_target
