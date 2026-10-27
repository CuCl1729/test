#> test:station/press
# @s = ボタン型のモードのステーション(実行位置は樽)。スロット26の作るボタンが取られたので、
# モードの craft を呼び、ボタンを置き直す

function test:station/run_craft with entity @s data.station
data modify block ~ ~ ~ Items[{Slot:26}] merge value {id:"lime_stained_glass_pane",components:{custom_data:{test:{button:1b}}}}
