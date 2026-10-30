#> test:debug/remove_vein
# @s = プレイヤー。足元のブロックの角から2ブロック以内の鉱脈のアマスタを、test:action と test:turn の
# 両方の同じ範囲から消す。もう片方のマップが読み込まれていないときは何もせず [鉱山を読み込む] を出す

execute unless dimension test:action unless dimension test:turn run return run tellraw @s [{text:"test:action か test:turn で使う",color:gray}]

function test:debug/vein_at
execute store result score #vein_ok test.temporary run function test:debug/vein_loaded with storage test: debug_work.vein_at
execute if score #vein_ok test.temporary matches 0 run return 0

scoreboard players set #vein_removed test.temporary 0
data modify storage test: debug_work.vein_at.r set value 2
data modify storage test: debug_work.vein_at.dim set value "action"
function test:debug/vein_kill with storage test: debug_work.vein_at
data modify storage test: debug_work.vein_at.dim set value "turn"
function test:debug/vein_kill with storage test: debug_work.vein_at
tellraw @s [{text:"鉱脈を消した: ",color:gray},{score:{name:"#vein_removed",objective:"test.temporary"},color:aqua},{text:"個(両マップ)",color:gray}]
