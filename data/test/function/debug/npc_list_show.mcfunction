#> test:debug/npc_list_show
# @s = プレイヤー。@macro id/name/role/x/y/z: NPC の定義

$tellraw @s [{text:" $(name) ",color:"yellow"},{text:"$(id) $(role) $(x) $(y) $(z) ",color:"gray"},{text:"[移動]",color:"aqua",click_event:{action:"run_command",command:"/function test:debug/npc_goto {id:$(id)}"}}]
