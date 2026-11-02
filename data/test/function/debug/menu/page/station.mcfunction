#> test:debug/menu/page/station
# @s = メニューを開いたプレイヤー。デバッグメニューの「ステーション」の欄(目次は test:debug/menu)

tellraw @s ""
tellraw @s [{text:"― ステーション ― ",color:gold},{text:"[目次]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/menu"}}]
data modify storage test: debug_work.station_queue set from storage test: asset.station_ids
function test:debug/menu/station_loop
tellraw @s [{text:"[レシピ一覧]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/recipe_list"}},{text:" "},{text:"[全レシピの材料]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/recipe_materials"}},{text:" (カスタムクラフター。1回分ずつ)",color:dark_gray}]
tellraw @s [{text:"[古いステーションを移行]",color:aqua,click_event:{action:"run_command",command:"/function test:station/migrate"}},{text:" (統合する前に置いたステーションを直す)",color:dark_gray}]
