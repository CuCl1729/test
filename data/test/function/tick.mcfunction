#> test:tick
# 
# @private



execute as @e[tag=projectile] at @s run function test:projectile/move
execute as @a run function test:cache/slot_check
execute as @e[type=player] run function test:ui/status/
execute as @e[tag=crafter] at @s if entity @e[type=player,distance=..6] run function test:magic/crafter/main
execute as @e[tag=weapon_forge] at @s if entity @e[type=player,distance=..6] run function test:craft/weapon/forge/main
execute as @e[tag=weapon_upgrade] at @s if entity @e[type=player,distance=..6] run function test:craft/weapon/upgrade/main
execute as @e[tag=magic_research] at @s if entity @e[type=player,distance=..6] run function test:craft/magic/research/main
execute as @e[tag=attract] at @s run function test:motion/player/attract/main
execute in test:arena as @e[tag=battle_marker] at @s run function test:battle/tick
execute as @e[tag=skill_minecart,tag=!skill_effect_minecart,tag=!target_minecart] at @s run function test:battle/ui/skill_type_cart_tick
execute as @e[tag=skill_effect_minecart] at @s run function test:battle/ui/skill_effect_cart_tick
execute as @e[tag=target_minecart] at @s run function test:battle/ui/target_cart_tick
execute as @e[tag=enemy] at @s run function test:status/hp_display_tick

# 召喚と同じtick内でtextを設定するとクライアントに反映されないことがあるため、次のtickで確定させる
# (毎ticktpして浮き上がらせる案は、tpのたびにtextの描画が崩れることが判明したため不採用。静止表示のみ)
execute as @e[tag=damage_pop_text_pending] run data modify entity @s text set value {text:"",extra:[{score:{name:"@s",objective:"test.damage_pop.value"},color:"red"}]}
tag @e[tag=damage_pop_text_pending] remove damage_pop_text_pending

execute as @e[tag=damage_pop] run scoreboard players remove @s test.damage_pop.life 1
execute as @e[tag=damage_pop,scores={test.damage_pop.life=..0}] run tag @s add kill

function test:debug/tick
execute as @a[tag=downed] run function test:status/downed_tick

scoreboard players add @e[tag=time] test.time 1

execute as @e[tag=executer] at @s rotated as @n[tag=Temp] run teleport @s ~ ~ ~ ~ ~

tag @e[tag=executer] remove executer

# 死亡するエンティティに騎乗しているtext_display(HP表示等)は道連れにしないと取り残されるため、
# 同じタイミングでkillタグを付けてまとめて消す
execute as @e[tag=kill] on passengers run tag @s add kill

scoreboard players reset @e[tag=kill]
kill @e[tag=kill]
