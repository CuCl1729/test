#> test:debug/menu/machine_button
# @macro id/name: 機械の種類と名前

$tellraw @s [{text:"$(name) ",color:"gold"},{text:"[エッグ]",color:"aqua",click_event:{action:"run_command",command:"/function test:machine/give_egg {id:$(id)}"}},{text:" "},{text:"[足元に設置]",color:"aqua",click_event:{action:"run_command",command:"/function test:debug/spawn_machine {id:$(id)}"}}]
