#> test:debug/research_all
# @s = プレイヤー。全部の研究を、コストを払わずに済にして解放する

function #oh_my_dat:please
data modify storage test: debug_work.give_queue set from storage test: asset.research_ids
function test:debug/research_all_loop
tellraw @s {text:"全部の研究を済にした",color:"gray"}
