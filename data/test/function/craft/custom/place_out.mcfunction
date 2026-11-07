# 作成ボタンはそのまま使っても何も起きない紙。製品のコンポーネントはコピーしない。
data modify storage test: craft_work.button set value {Slot:16b,id:"minecraft:paper",count:1,components:{"minecraft:custom_name":{text:"作成: ",italic:false,extra:[{text:""}]}}}
data modify storage test: craft_work.button.components."minecraft:custom_name".extra[0].text set from storage test: craft_work.rec.name
function test:station/action/stamp {item:"craft_work.button",slot:16}
data modify block ~ ~ ~ Items append from storage test: craft_work.button
