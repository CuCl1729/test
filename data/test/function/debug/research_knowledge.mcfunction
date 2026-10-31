#> test:debug/research_knowledge
# @s = プレイヤー。知識を全属性に +10 する

function #oh_my_dat:please
data modify storage test: debug_work.kt set from storage test: asset.knowledge_types
function test:debug/research_knowledge_loop
tellraw @s {text:"知識 全属性+10",color:"gray"}
