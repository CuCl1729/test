#> test:debug/mine_status_line
# @s = プレイヤー。@macro id/dim: 鉱山のidとマップ。「<id> <dim>: 人 有/無 / あと N秒」の1行を出す

scoreboard players set #mine_status_in test.temporary 0
$execute store result score #mine_status_in test.temporary run data get storage test: mine_state.$(dim).$(id).occupied
scoreboard players set #mine_status_left test.temporary 0
$execute store result score #mine_status_left test.temporary run data get storage test: mine_state.$(dim).$(id).ready_at
scoreboard players operation #mine_status_left test.temporary -= #mine_now test.temporary
scoreboard players set #mine_ticks test.temporary 20
scoreboard players operation #mine_status_left test.temporary /= #mine_ticks test.temporary
execute if score #mine_status_left test.temporary matches ..-1 run scoreboard players set #mine_status_left test.temporary 0

$execute if score #mine_status_in test.temporary matches 1 run tellraw @s [{text:"$(id) $(dim): ",color:gray},{text:"人 有",color:green},{text:" / あと ",color:gray},{score:{name:"#mine_status_left",objective:"test.temporary"},color:aqua},{text:"秒",color:gray}]
$execute if score #mine_status_in test.temporary matches 0 run tellraw @s [{text:"$(id) $(dim): ",color:gray},{text:"人 無",color:dark_gray},{text:" / あと ",color:gray},{score:{name:"#mine_status_left",objective:"test.temporary"},color:aqua},{text:"秒",color:gray}]
