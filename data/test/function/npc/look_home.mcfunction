#> test:npc/look_home
# @s = 近くにプレイヤーがいなくなった NPC の見た目。定義の向き(同じ所のインタラクションの data.npc.def.yaw)に戻す

tag @s remove npc_looking
execute at @s run function test:npc/look_home_set with entity @n[type=interaction,tag=npc_i,distance=..1] data.npc.def
