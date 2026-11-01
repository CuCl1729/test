#> test:debug/flags
# @s = プレイヤー。ストーリーのフラグ(全員共通)と、自分のフラグの一覧と値を出す。値を変えるボタンはコマンドを入力欄に入れる

function #oh_my_dat:please
tellraw @s {text:"― フラグ ―",color:"gold"}
tellraw @s [{text:" ストーリー: ",color:"gray"},{storage:"test:",nbt:"story.flag",color:"aqua"}]
tellraw @s [{text:" 自分: ",color:"gray"},{storage:"oh_my_dat:",nbt:"_[-4][-4][-4][-4][-4][-4][-4][-4].test.flag",color:"aqua"}]
tellraw @s [{text:"[ストーリーのフラグを変える…]",color:"aqua",click_event:{action:"suggest_command",command:"/data modify storage test: story.flag.名前 set value 1"}},{text:" "},{text:"[自分のフラグを変える…]",color:"aqua",click_event:{action:"suggest_command",command:"/function test:debug/flag_set {name:名前,value:1}"}}]
