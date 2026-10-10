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

tellraw @s {text:"― 監視(サイドバー) ―",color:gold}
data modify storage test: debug_work.watch_queue set value []
data modify storage test: debug_work.watch_queue set from storage test: debug.watch
function test:debug/menu/watch_loop
execute unless data storage test: debug.watch[0] run tellraw @s {text:"(監視中の値はありません)",color:dark_gray}
tellraw @s [{text:"[追加…]",color:aqua,click_event:{action:"suggest_command",command:"/function test:debug/watch/add {name:\"#damage\",objective:\"test.physics_damage\"}"}},{text:" "},{text:"[全部消す]",color:red,click_event:{action:"run_command",command:"/function test:debug/watch/clear"}}]
