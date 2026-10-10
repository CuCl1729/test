#> test:debug/inspect/self
# @s = 操作したプレイヤー。自分の状態を表示する

tag @s add debug_viewer
function test:debug/inspect/show
tag @s remove debug_viewer
