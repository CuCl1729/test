#> test:debug/menu/page/machine
# @s = メニューを開いたプレイヤー。デバッグメニューの「機械」の欄(目次は test:debug/menu)

tellraw @s ""
tellraw @s [{text:"― 機械 ― ",color:gold},{text:"[目次]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/menu"}}]
data modify storage test: debug_work.casing_queue set from storage test: asset.casing_ids
function test:debug/menu/casing_loop
tellraw @s [{text:"[搬入口×8]",color:aqua,click_event:{action:"run_command",command:"/function test:item/machine/give {id:port_in,count:8}"}},{text:" "},{text:"[搬出口×8]",color:aqua,click_event:{action:"run_command",command:"/function test:item/machine/give {id:port_out,count:8}"}},{text:" "},{text:"[ホッパー×16]",color:aqua,click_event:{action:"run_command",command:"/give @s minecraft:hopper 16"}},{text:" "},{text:"[レンチ]",color:aqua,click_event:{action:"run_command",command:"/function test:item/machine/give {id:wrench,count:1}"}}]
data modify storage test: debug_work.machine_queue set from storage test: asset.machine_ids
function test:debug/menu/machine_loop
tellraw @s [{text:"[石炭×16]",color:aqua,click_event:{action:"run_command",command:"/give @s minecraft:coal 16"}},{text:" "},{text:"[近くの機械の状態]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/machine_status"}},{text:" (形・燃料・処理中のもの)",color:dark_gray}]
