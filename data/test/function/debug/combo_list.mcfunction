#> test:debug/combo_list
# @s = 実行したプレイヤー。組み合わせの表(スプレッドシート生成の asset.magic.combos)を1行ずつ出す。
# クラフトが弾かれたときに「どの行に当たるはずか」を見るための物
tellraw @s ""
tellraw @s {text:"― 組み合わせの表 ―",color:gold}
data modify storage test: debug_work.combo_queue set from storage test: asset.magic.combos
function test:debug/combo_list_loop
