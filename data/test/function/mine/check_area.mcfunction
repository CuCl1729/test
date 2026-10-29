#> test:mine/check_area
# @macro id/dim/x1/y1/z1/dx/dy/dz: 鉱山のid・マップ(action / turn)・範囲。範囲の中に人がいるかを調べて
# storage test: mine_state.<dim>.<id>.occupied に書き、前回は誰もいなくて今は1人以上いて、
# 次にリセットできる時刻(ready_at。#mine_now と同じゲーム内の時刻 tick)を過ぎていれば元に戻す

scoreboard players set #mine_in test.temporary 0
$execute in test:$(dim) positioned $(x1) $(y1) $(z1) if entity @a[dx=$(dx),dy=$(dy),dz=$(dz)] run scoreboard players set #mine_in test.temporary 1

scoreboard players set #mine_prev test.temporary 0
$execute store result score #mine_prev test.temporary run data get storage test: mine_state.$(dim).$(id).occupied
$execute store result storage test: mine_state.$(dim).$(id).occupied byte 1 run scoreboard players get #mine_in test.temporary

execute unless score #mine_prev test.temporary matches 0 run return 0
execute unless score #mine_in test.temporary matches 1 run return 0

# ready_at が無い(一度もリセットしていない)ときは0なので、すぐ通る
scoreboard players set #mine_ready test.temporary 0
$execute store result score #mine_ready test.temporary run data get storage test: mine_state.$(dim).$(id).ready_at
execute if score #mine_now test.temporary < #mine_ready test.temporary run return 0

$function test:mine/reset {id:"$(id)",dim:"$(dim)"}
