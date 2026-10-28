#> test:equip/proc/cast_battle_pick_nearest
# @s = 唱えるプレイヤー(at @s)。同じ戦闘で生きている敵のうち、一番近い1体に battle_target を付ける

execute as @e[tag=battle_member,tag=enemy,distance=..64,scores={test.status.hp=1..},sort=nearest] if score @s test.battle.id = #proc_cast_battle test.battle.id run return run tag @s add battle_target
