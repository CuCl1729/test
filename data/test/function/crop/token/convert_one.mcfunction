#> test:crop/token/convert_one
# @s = プレイヤー。@macro id: 作物。その目印を全部消し、消した個数の回数だけ、行ごとの個数を決めて渡す

scoreboard players set #crop_n test.temporary 0
$execute store result score #crop_n test.temporary run clear @s *[custom_data~{test:{crop_token:"$(id)"}}]
execute if score #crop_n test.temporary matches ..0 run return 0
$data modify storage test: crop_work.drops_def set from storage test: asset.crop.$(id).drops
$function test:debug/log {msg:"作物: $(id)"}
function test:crop/token/token_loop
