#> test:debug/give_ore
# @s = プレイヤー。@macro id: 原石の種類。レア度1〜5を10個ずつ渡す

$function test:item/ore/give {id:"$(id)",rare:1,count:10}
$function test:item/ore/give {id:"$(id)",rare:2,count:10}
$function test:item/ore/give {id:"$(id)",rare:3,count:10}
$function test:item/ore/give {id:"$(id)",rare:4,count:10}
$function test:item/ore/give {id:"$(id)",rare:5,count:10}
