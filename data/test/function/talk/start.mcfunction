#> test:talk/start
# @s = NPC に話しかけたプレイヤー(NPC の入口 test:npc/generated/entry/<id> から。oh_my_dat は @s を指している)。
# @macro npc/node: NPC と最初のノード。会話の状態 test.talk = {npc, node, opts} を作って、ノードを出す

$data modify storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.talk set value {npc:"$(npc)",node:"",opts:{}}
tag @s add talking
$function test:talk/goto {npc:"$(npc)",node:"$(node)"}
