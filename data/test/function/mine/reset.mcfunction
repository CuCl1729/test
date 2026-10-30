#> test:mine/reset
# @macro id/dim: 鉱山のidとマップ(action / turn)。そのマップの鉱山を元に戻す
# 1. 範囲の中の鉱脈のアマスタ(tag=mine_vein)が、それぞれ自分の鉱脈の構造物を自分の位置に置き直す
# 2. 範囲の中で足元か頭がブロックに埋まった人を入口へ移す
# 3. 次にリセットできる時刻を「今 + リセット間隔」にする  4. デバッグ表示に出す
# (test:mine/check_area と、間隔を無視する test:debug/reset_mine から呼ぶ)

execute store result score #mine_now test.temporary run time query gametime
$data modify storage test: mine_work.reset set from storage test: asset.mine.$(id)

data modify storage test: mine_work.veins_arg set from storage test: mine_work.reset.area
$data modify storage test: mine_work.veins_arg.dim set value "$(dim)"
function test:mine/place_veins with storage test: mine_work.veins_arg

data modify storage test: mine_work.rescue set from storage test: mine_work.reset.area
data modify storage test: mine_work.rescue.ex set from storage test: mine_work.reset.entrance.x
data modify storage test: mine_work.rescue.ey set from storage test: mine_work.reset.entrance.y
data modify storage test: mine_work.rescue.ez set from storage test: mine_work.reset.entrance.z
$data modify storage test: mine_work.rescue.dim set value "$(dim)"
function test:mine/rescue with storage test: mine_work.rescue

scoreboard players set #mine_ticks test.temporary 20
execute store result score #mine_next test.temporary run data get storage test: mine_work.reset.interval
scoreboard players operation #mine_next test.temporary *= #mine_ticks test.temporary
scoreboard players operation #mine_next test.temporary += #mine_now test.temporary
$execute store result storage test: mine_state.$(dim).$(id).ready_at int 1 run scoreboard players get #mine_next test.temporary

$function test:debug/log {msg:"鉱山リセット: $(id) $(dim)"}
