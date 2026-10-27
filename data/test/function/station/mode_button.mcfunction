#> test:station/mode_button
# @macro label/next_label/next_icon: 今のモード名、次のモード名とそのアイコン。
# スロット20に「モード: 今 ▶ 次に切り替え」のボタンを置く(取ると test:station/next_mode)

$data modify block ~ ~ ~ Items append value {Slot:20b,id:"$(next_icon)",count:1,components:{"minecraft:custom_name":[{text:"モード: ",italic:false,color:"gray"},{text:"$(label)",color:"white"},{text:" ▶ ",color:"gray"},{text:"$(next_label)",color:"yellow"},{text:" に切り替え",color:"gray"}],"minecraft:custom_data":{test:{station_ui:1b}}}}
