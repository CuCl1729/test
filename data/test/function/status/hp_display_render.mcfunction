#> test:status/hp_display_render
# @s = 敵に騎乗しているtext_display本体。#hp_display_visible/#hp_display_filled/#hp_display_cur/#hp_display_max
# (いずれもtest.temporary)は呼び出し元(status/hp_display_tick)が計算済み。数値は「@sの持つスコア」として
# text_display自身に持たせ、score型のテキストコンポーネント(name:"@s")で参照する。これは
# 一時的な共有スコア(test.temporary)を直接参照すると、同tick内で処理される他の敵の値に上書きされてしまい
# 表示が壊れるため(実際にこの方式で数値が表示されない不具合が発生した経緯がある)

# HP/HP_MAXは内部的に100倍値で保持されているため、表示時は100で割って実数値に戻す
scoreboard players operation @s test.hp_display.cur = #hp_display_cur test.temporary
scoreboard players operation @s test.hp_display.cur /= #100 test.constant
scoreboard players operation @s test.hp_display.max = #hp_display_max test.temporary
scoreboard players operation @s test.hp_display.max /= #100 test.constant

execute if score #hp_display_visible test.temporary matches 0 run data modify entity @s text set value {text:""}

execute if score #hp_display_visible test.temporary matches 1 if score #hp_display_filled test.temporary matches 0 run data modify entity @s text set value {text:"",extra:[{text:"",color:"green"},{text:"■■■■■■■■■■",color:"dark_gray"},{text:" "},{score:{name:"@s",objective:"test.hp_display.cur"}},{text:"/"},{score:{name:"@s",objective:"test.hp_display.max"}}]}
execute if score #hp_display_visible test.temporary matches 1 if score #hp_display_filled test.temporary matches 1 run data modify entity @s text set value {text:"",extra:[{text:"■",color:"green"},{text:"■■■■■■■■■",color:"dark_gray"},{text:" "},{score:{name:"@s",objective:"test.hp_display.cur"}},{text:"/"},{score:{name:"@s",objective:"test.hp_display.max"}}]}
execute if score #hp_display_visible test.temporary matches 1 if score #hp_display_filled test.temporary matches 2 run data modify entity @s text set value {text:"",extra:[{text:"■■",color:"green"},{text:"■■■■■■■■",color:"dark_gray"},{text:" "},{score:{name:"@s",objective:"test.hp_display.cur"}},{text:"/"},{score:{name:"@s",objective:"test.hp_display.max"}}]}
execute if score #hp_display_visible test.temporary matches 1 if score #hp_display_filled test.temporary matches 3 run data modify entity @s text set value {text:"",extra:[{text:"■■■",color:"green"},{text:"■■■■■■■",color:"dark_gray"},{text:" "},{score:{name:"@s",objective:"test.hp_display.cur"}},{text:"/"},{score:{name:"@s",objective:"test.hp_display.max"}}]}
execute if score #hp_display_visible test.temporary matches 1 if score #hp_display_filled test.temporary matches 4 run data modify entity @s text set value {text:"",extra:[{text:"■■■■",color:"green"},{text:"■■■■■■",color:"dark_gray"},{text:" "},{score:{name:"@s",objective:"test.hp_display.cur"}},{text:"/"},{score:{name:"@s",objective:"test.hp_display.max"}}]}
execute if score #hp_display_visible test.temporary matches 1 if score #hp_display_filled test.temporary matches 5 run data modify entity @s text set value {text:"",extra:[{text:"■■■■■",color:"green"},{text:"■■■■■",color:"dark_gray"},{text:" "},{score:{name:"@s",objective:"test.hp_display.cur"}},{text:"/"},{score:{name:"@s",objective:"test.hp_display.max"}}]}
execute if score #hp_display_visible test.temporary matches 1 if score #hp_display_filled test.temporary matches 6 run data modify entity @s text set value {text:"",extra:[{text:"■■■■■■",color:"green"},{text:"■■■■",color:"dark_gray"},{text:" "},{score:{name:"@s",objective:"test.hp_display.cur"}},{text:"/"},{score:{name:"@s",objective:"test.hp_display.max"}}]}
execute if score #hp_display_visible test.temporary matches 1 if score #hp_display_filled test.temporary matches 7 run data modify entity @s text set value {text:"",extra:[{text:"■■■■■■■",color:"green"},{text:"■■■",color:"dark_gray"},{text:" "},{score:{name:"@s",objective:"test.hp_display.cur"}},{text:"/"},{score:{name:"@s",objective:"test.hp_display.max"}}]}
execute if score #hp_display_visible test.temporary matches 1 if score #hp_display_filled test.temporary matches 8 run data modify entity @s text set value {text:"",extra:[{text:"■■■■■■■■",color:"green"},{text:"■■",color:"dark_gray"},{text:" "},{score:{name:"@s",objective:"test.hp_display.cur"}},{text:"/"},{score:{name:"@s",objective:"test.hp_display.max"}}]}
execute if score #hp_display_visible test.temporary matches 1 if score #hp_display_filled test.temporary matches 9 run data modify entity @s text set value {text:"",extra:[{text:"■■■■■■■■■",color:"green"},{text:"■",color:"dark_gray"},{text:" "},{score:{name:"@s",objective:"test.hp_display.cur"}},{text:"/"},{score:{name:"@s",objective:"test.hp_display.max"}}]}
execute if score #hp_display_visible test.temporary matches 1 if score #hp_display_filled test.temporary matches 10.. run data modify entity @s text set value {text:"",extra:[{text:"■■■■■■■■■■",color:"green"},{text:"",color:"dark_gray"},{text:" "},{score:{name:"@s",objective:"test.hp_display.cur"}},{text:"/"},{score:{name:"@s",objective:"test.hp_display.max"}}]}
