#> test:machine/fuel/clean_loop
# @s = 機械のマーカー(実行位置は燃料の入れ物)。machine_work.items(入れ物の中身のコピー)を1つずつ見て、燃料でなければ出す

execute unless data storage test: machine_work.items[0] run return 0
scoreboard players set #machine_ok test.temporary 0
execute store result score #machine_ok test.temporary run function test:machine/fuel/is_fuel with storage test: machine_work.items[0]
execute if score #machine_ok test.temporary matches 0 run function test:machine/eject with storage test: machine_work.items[0]
data remove storage test: machine_work.items[0]
function test:machine/fuel/clean_loop
