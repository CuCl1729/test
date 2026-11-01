#> test:npc/place/all
# 両方のマップ(test:action・test:turn)の同じ座標に、一覧の NPC を置く。採取ポイント(test:gather/place/)と同じ形:
# 一覧から消えたもの・定義(asset.npc.<id>)が変わったものを片付け、読み込まれている場所で無いものを置く

scoreboard players set #npc_clock test.time 0
execute as @e[type=interaction,tag=npc_i] at @s run function test:npc/place/check with entity @s data.npc
data modify storage test: npc_work.queue set from storage test: asset.npc_ids
function test:npc/place/loop
