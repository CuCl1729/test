#> test:debug/menu/page/mine
# @s = メニューを開いたプレイヤー。デバッグメニューの「採掘」の欄(目次は test:debug/menu)

tellraw @s ""
tellraw @s [{text:"― 採掘 ― ",color:gold},{text:"[目次]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/menu"}}]
tellraw @s [{text:"[ツルハシ全種]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/give_pickaxes"}},{text:" (アドベンチャーモードで鉱山の鉱石だけ掘れる)",color:dark_gray}]
tellraw @s [{text:"[原石全種]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/give_ores"}},{text:" (全種類×レア度1〜5を10個ずつ)",color:dark_gray}]
tellraw @s [{text:"[鉱山リセット]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/reset_mine"}},{text:" "},{text:"[鉱山の状態]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/mine_status"}},{text:" (リセットは今いる鉱山を、間隔を無視して元に戻す)",color:dark_gray}]
tellraw @s [{text:"[鉱山を読み込む]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/mine_load {mode:add}"}},{text:" "},{text:"[やめる]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/mine_load {mode:remove}"}},{text:" (両マップで forceload。鉱脈を置く・消す・調べる前に)",color:dark_gray}]
data modify storage test: debug_work.vein_queue set from storage test: asset.vein_ids
function test:debug/menu/vein_loop
tellraw @s [{text:"[鉱脈のずれを調べる]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/check_veins"}},{text:" (片方のマップにだけある鉱脈など)",color:dark_gray}]
tellraw @s [{text:"[近くの鉱脈を消す]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/remove_vein"}},{text:" "},{text:"[鉱脈の名前を表示]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/show_veins {visible:1b}"}},{text:" "},{text:"[隠す]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/show_veins {visible:0b}"}}]
