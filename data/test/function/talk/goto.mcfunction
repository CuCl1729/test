#> test:talk/goto
# @s = プレイヤー。@macro npc/node: その NPC の位置で、ノードの関数(test:talk/generated/node/<id>)を呼ぶ(全員のノードは NPC の近くの人に出すため)

$execute at @e[type=interaction,tag=npc_i,tag=npc.$(npc),sort=nearest,limit=1] run function test:talk/generated/node/$(node)
