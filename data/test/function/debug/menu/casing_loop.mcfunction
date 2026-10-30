#> test:debug/menu/casing_loop
# @s = メニューを開いたプレイヤー。debug_work.casing_queue(asset.casing_ids のコピー)を1件ずつ、「[<筐体の名前>×64]」の1行にして出す

execute unless data storage test: debug_work.casing_queue[0] run return 0
data modify storage test: debug_work.casing_arg set value {id:"",name:""}
data modify storage test: debug_work.casing_arg.id set from storage test: debug_work.casing_queue[0]
function test:debug/menu/casing_button with storage test: debug_work.casing_arg
data remove storage test: debug_work.casing_queue[0]
function test:debug/menu/casing_loop
