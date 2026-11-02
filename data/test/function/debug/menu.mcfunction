#> test:debug/menu
# @s = メニューを開いたプレイヤー。デバッグメニューの目次。欄ごとのページ(test:debug/menu/page/<欄>)を開くボタンを出す
# (全部を1回で出すと100行を超え、チャットの上の方がクリックできなくなるため)

tellraw @s ""
tellraw @s {text:"===== デバッグメニュー =====",color:gold}

# サイドバー(戦闘情報・監視中の値)
execute if score #debug test.debug.enabled matches 1 run tellraw @s [{text:"サイドバー表示 ",color:gray},{text:"[ON]",color:green,bold:true},{text:" "},{text:"[OFF]",color:dark_gray,click_event:{action:"run_command",command:"/function test:debug/menu/set_sidebar {value:0}"}}]
execute unless score #debug test.debug.enabled matches 1 run tellraw @s [{text:"サイドバー表示 ",color:gray},{text:"[ON]",color:dark_gray,click_event:{action:"run_command",command:"/function test:debug/menu/set_sidebar {value:1}"}},{text:" "},{text:"[OFF]",color:red,bold:true}]
tellraw @s [{text:"[ログ]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/menu/page/log"}},{text:" "},{text:"[乱数]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/menu/page/rng {p:0}"}},{text:" "},{text:"[状態の表示]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/menu/page/state"}},{text:" "},{text:"[アイテム]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/menu/page/item"}},{text:" "},{text:"[監視]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/menu/page/watch"}}]
tellraw @s [{text:"[採掘]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/menu/page/mine"}},{text:" "},{text:"[採取]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/menu/page/gather"}},{text:" "},{text:"[農耕]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/menu/page/farm"}},{text:" "},{text:"[研究]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/menu/page/research"}},{text:" "},{text:"[工場]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/menu/page/factory"}},{text:" "},{text:"[機械]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/menu/page/machine"}}]
tellraw @s [{text:"[敵]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/menu/page/enemy"}},{text:" "},{text:"[ステーション]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/menu/page/station"}},{text:" "},{text:"[NPC・クエスト]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/menu/page/npc"}}]
