#> test:talk/press_go
# @s = プレイヤー。@macro i/npc: 押された選択肢の番号と、話している NPC

$execute unless data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.talk.opts.o$(i) run return 0
$execute unless entity @e[type=interaction,tag=npc_i,tag=npc.$(npc),distance=..8] run return run function test:talk/end
$data modify storage test: talk_work.p.node set from storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.talk.opts.o$(i)
function test:talk/goto with storage test: talk_work.p
