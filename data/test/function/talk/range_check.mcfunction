#> test:talk/range_check
# @s = プレイヤー。@macro npc: 話している NPC

$execute unless entity @e[type=interaction,tag=npc_i,tag=npc.$(npc),distance=..8] run function test:talk/end
