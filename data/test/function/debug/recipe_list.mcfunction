#> test:debug/recipe_list
# @s = プレイヤー。カスタムクラフターの全レシピを、作れるか(作れる / 未研究 / 研究済み)・形・材料・出るものと一緒に出す

function #oh_my_dat:please
tellraw @s {text:"― レシピ ―",color:"gold"}
data modify storage test: debug_work.give_queue set from storage test: asset.recipe_ids
function test:debug/recipe_list_loop
