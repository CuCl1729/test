# 出力枠は作成ボタン。研究の有無はボタンを取った人について確定時に判定する。
function test:craft/custom/eval
execute if data entity @s data.crafter.show run data remove block ~ ~ ~ Items[{Slot:16b}]
data remove entity @s data.crafter.show
data remove entity @s data.crafter.recipe
data remove entity @s data.station.buttons.s16
data modify entity @s data.crafter.grid set from storage test: craft_work.grid
execute unless score #cc_ok test.temporary matches 1.. run return 0
data modify entity @s data.crafter.recipe set from storage test: craft_work.match.recipe
function test:craft/custom/place_out with storage test: craft_work.rec
data modify entity @s data.crafter.show set from block ~ ~ ~ Items[{Slot:16b}]
data remove entity @s data.crafter.show.Slot
