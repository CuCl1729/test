#> test:debug/research_show
# @s = プレイヤー。自分の知識の量と、調べ済みの観測を出す

function #oh_my_dat:please
tellraw @s {text:"― 知識 ―",color:"gold"}
data modify storage test: debug_work.kt set from storage test: asset.knowledge_types
function test:debug/research_show_knowledge
tellraw @s {text:"― 調べ済み ―",color:"gold"}
data modify storage test: debug_work.give_queue set from storage test: asset.scan_ids
function test:debug/research_show_scans
