#> test:debug/menu/casing_button_add
# @s = メニューを開いたプレイヤー。@macro id/name: 筐体の種類と名前

$tellraw @s [{text:"[$(name)×64]",color:"aqua",click_event:{action:"run_command",command:"/function test:item/machine/give {id:casing_$(id),count:64}"}},{text:" (筐体。全部同じ種類で組む)",color:"dark_gray"}]
