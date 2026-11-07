# ボタンを取った枠へ戻すので、満杯でも渡せる。製品をそこへ置けた場合だけ、同じ処理の中で材料を消費する。
execute in minecraft:overworld run item replace block 0 -64 0 container.0 with stone
execute in minecraft:overworld run data modify block 0 -64 0 Items[{Slot:0b}] merge from storage test: loot.item
$execute in minecraft:overworld store success score #cc_delivered test.temporary run item replace entity @s $(dest) from block 0 -64 0 container.0
execute if score #cc_delivered test.temporary matches 1 run function test:craft/custom/consume
