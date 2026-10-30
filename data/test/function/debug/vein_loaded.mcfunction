#> test:debug/vein_loaded
# @s = プレイヤー。@macro x/y/z: ブロックの座標。test:action と test:turn の両方でその位置が読み込まれていれば 1 を返す。
# 読み込まれていないマップがあれば、[鉱山を読み込む](test:debug/mine_load)を出して 0 を返す。
# 読み込まれていない場所では、アマスタを探すことも消すことも確実にはできないため

$execute in test:action unless loaded $(x) $(y) $(z) run tellraw @s [{text:"test:action が読み込まれていない ",color:red},{text:"[鉱山を読み込む]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/mine_load {mode:add}"}}]
$execute in test:turn unless loaded $(x) $(y) $(z) run tellraw @s [{text:"test:turn が読み込まれていない ",color:red},{text:"[鉱山を読み込む]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/mine_load {mode:add}"}}]
$execute in test:action unless loaded $(x) $(y) $(z) run return 0
$execute in test:turn unless loaded $(x) $(y) $(z) run return 0
return 1
