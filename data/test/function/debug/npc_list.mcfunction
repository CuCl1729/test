#> test:debug/npc_list
# @s = プレイヤー。NPC の一覧を出す(押すと test:action のその NPC の前へ移る)

tellraw @s {text:"― NPC ―",color:"gold"}
data modify storage test: debug_work.give_queue set from storage test: asset.npc_ids
function test:debug/npc_list_loop
