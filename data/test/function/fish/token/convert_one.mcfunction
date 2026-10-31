#> test:fish/token/convert_one
# @s = プレイヤー。@macro id: 中身のid。その目印を全部消し、消した個数の回数だけ素材を選んで(rng のキー fish_pick)、
# 個数を決めて(fish_count)足元に落とす(すぐ拾う。持ち物がいっぱいでも消えない)

scoreboard players set #fish_n test.temporary 0
$execute store result score #fish_n test.temporary run clear @s *[custom_data~{test:{fish_token:"$(id)"}}]
execute if score #fish_n test.temporary matches ..0 run return 0
$data modify storage test: fish_work.pool set from storage test: asset.fish_pool.$(id)
$function test:debug/log {msg:"釣り: $(id)"}
function test:fish/token/roll_loop
