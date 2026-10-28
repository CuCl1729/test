#> test:debug/menu/enemy_button
# @macro id: 敵のid。「[id]」(押すと test:turn の近くに召喚)の1行を出す

$tellraw @s [{text:"[$(id)]",color:"red",click_event:{action:"run_command",command:"/function test:debug/spawn_enemy_id {id:$(id)}"}},{text:" フィールド(test:turn)に召喚",color:"dark_gray"}]
