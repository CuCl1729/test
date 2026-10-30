#> test:debug/menu
# @s = メニューを開いたプレイヤー。デバッグ機能の一覧をチャットに出し、各ボタンはクリックで実行する
# (値の入力が要るものはsuggest_commandで入力欄に入れる)

tellraw @s {text:"===== デバッグメニュー =====",color:gold}

# サイドバー(戦闘情報・監視中の値)
execute if score #debug test.debug.enabled matches 1 run tellraw @s [{text:"サイドバー表示 ",color:gray},{text:"[ON]",color:green,bold:true},{text:" "},{text:"[OFF]",color:dark_gray,click_event:{action:"run_command",command:"/function test:debug/menu/set_sidebar {value:0}"}}]
execute unless score #debug test.debug.enabled matches 1 run tellraw @s [{text:"サイドバー表示 ",color:gray},{text:"[ON]",color:dark_gray,click_event:{action:"run_command",command:"/function test:debug/menu/set_sidebar {value:1}"}},{text:" "},{text:"[OFF]",color:red,bold:true}]

tellraw @s {text:"― ログ ―",color:gold}
function test:debug/menu/log_line {cat:"damage",label:"ダメージ計算"}
function test:debug/menu/log_line {cat:"battle",label:"戦闘の進行"}

tellraw @s {text:"― 乱数 ―",color:gold}
data modify storage test: debug_work.rng_queue set from storage test: asset.debug.rng
function test:debug/menu/rng_loop

tellraw @s {text:"― 状態の表示 ―",color:gold}
tellraw @s [{text:"[自分]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/inspect/self"}},{text:" "},{text:"[近くの対象]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/inspect/nearest"}},{text:" (16ブロック以内で最も近い、HPを持つプレイヤー以外)",color:dark_gray}]

tellraw @s {text:"― アイテム ―",color:gold}
tellraw @s [{text:"[素材全種]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/give_materials"}},{text:" (工房の材料・触媒・特殊素材・型紙)",color:dark_gray}]
tellraw @s [{text:"[ルーン全種]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/give_runes"}},{text:" "},{text:"[消耗品全種×16]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/give_consumables"}},{text:" (強化台の付与モードで装備の枠に入れる)",color:dark_gray}]

tellraw @s {text:"― 採掘 ―",color:gold}
tellraw @s [{text:"[ツルハシ全種]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/give_pickaxes"}},{text:" (アドベンチャーモードで鉱山の鉱石だけ掘れる)",color:dark_gray}]
tellraw @s [{text:"[原石全種]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/give_ores"}},{text:" (全種類×レア度1〜5を10個ずつ)",color:dark_gray}]
tellraw @s [{text:"[鉱山リセット]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/reset_mine"}},{text:" "},{text:"[鉱山の状態]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/mine_status"}},{text:" (リセットは今いる鉱山を、間隔を無視して元に戻す)",color:dark_gray}]
tellraw @s [{text:"[鉱山を読み込む]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/mine_load {mode:add}"}},{text:" "},{text:"[やめる]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/mine_load {mode:remove}"}},{text:" (両マップで forceload。鉱脈を置く・消す・調べる前に)",color:dark_gray}]
data modify storage test: debug_work.vein_queue set from storage test: asset.vein_ids
function test:debug/menu/vein_loop
tellraw @s [{text:"[鉱脈のずれを調べる]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/check_veins"}},{text:" (片方のマップにだけある鉱脈など)",color:dark_gray}]
tellraw @s [{text:"[近くの鉱脈を消す]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/remove_vein"}},{text:" "},{text:"[鉱脈の名前を表示]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/show_veins {visible:1b}"}},{text:" "},{text:"[隠す]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/show_veins {visible:0b}"}}]

tellraw @s {text:"― 機械 ―",color:gold}
data modify storage test: debug_work.casing_queue set from storage test: asset.casing_ids
function test:debug/menu/casing_loop
tellraw @s [{text:"[搬入口×8]",color:aqua,click_event:{action:"run_command",command:"/function test:item/machine/give {id:port_in,count:8}"}},{text:" "},{text:"[搬出口×8]",color:aqua,click_event:{action:"run_command",command:"/function test:item/machine/give {id:port_out,count:8}"}},{text:" "},{text:"[ホッパー×16]",color:aqua,click_event:{action:"run_command",command:"/function test:item/machine/give {id:machine_hopper,count:16}"}},{text:" "},{text:"[レンチ]",color:aqua,click_event:{action:"run_command",command:"/function test:item/machine/give {id:wrench,count:1}"}}]
data modify storage test: debug_work.machine_queue set from storage test: asset.machine_ids
function test:debug/menu/machine_loop
tellraw @s [{text:"[石炭×16]",color:aqua,click_event:{action:"run_command",command:"/give @s minecraft:coal 16"}},{text:" "},{text:"[近くの機械の状態]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/machine_status"}},{text:" (形・燃料・処理中のもの)",color:dark_gray}]

tellraw @s {text:"― 敵 ―",color:gold}
data modify storage test: debug_work.enemy_queue set from storage test: asset.enemy_ids
function test:debug/menu/enemy_loop

tellraw @s {text:"― ステーション ―",color:gold}
data modify storage test: debug_work.station_queue set from storage test: asset.station_ids
function test:debug/menu/station_loop
tellraw @s [{text:"[古いステーションを移行]",color:aqua,click_event:{action:"run_command",command:"/function test:station/migrate"}},{text:" (統合する前に置いたステーションを直す)",color:dark_gray}]

tellraw @s {text:"― 監視(サイドバー) ―",color:gold}
data modify storage test: debug_work.watch_queue set value []
data modify storage test: debug_work.watch_queue set from storage test: debug.watch
function test:debug/menu/watch_loop
execute unless data storage test: debug.watch[0] run tellraw @s {text:"(監視中の値はありません)",color:dark_gray}
tellraw @s [{text:"[追加…]",color:aqua,click_event:{action:"suggest_command",command:"/function test:debug/watch/add {name:\"#damage\",objective:\"test.physics_damage\"}"}},{text:" "},{text:"[全部消す]",color:red,click_event:{action:"run_command",command:"/function test:debug/watch/clear"}}]
