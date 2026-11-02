#> test:debug/menu/page/gather
# @s = メニューを開いたプレイヤー。デバッグメニューの「採取」の欄(目次は test:debug/menu)

tellraw @s ""
tellraw @s [{text:"― 採取 ― ",color:gold},{text:"[目次]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/menu"}}]
tellraw @s [{text:"[採取ポイントのエッグ全種]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/give_gather_eggs"}},{text:" "},{text:"[近くの採取ポイントを消す]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/remove_gather"}},{text:" (エッグは両マップに置く)",color:dark_gray}]
tellraw @s [{text:"[採取の道具全種]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/give_gather_tools"}},{text:" "},{text:"[近くの採取ポイント]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/gather_status"}},{text:" "},{text:"[近くを今すぐ復活]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/gather_respawn"}}]
tellraw @s [{text:"[ここの釣り場]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/fishing_here"}},{text:" (当てはまる行と中身)",color:dark_gray}]
data modify storage test: debug_work.fish_pool_queue set from storage test: asset.fish_pool_ids
function test:debug/menu/fish_loop
