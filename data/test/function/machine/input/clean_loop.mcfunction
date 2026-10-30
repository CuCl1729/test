#> test:machine/input/clean_loop
# @s = 機械のマーカー(実行位置は原石の入れ物)。machine_work.items(入れ物の中身のコピー)を1つずつ見て、受け付けなければ出す

execute unless data storage test: machine_work.items[0] run return 0
scoreboard players set #machine_ok test.temporary 0
execute store result score #machine_ok test.temporary run function test:machine/input/accepts
execute if score #machine_ok test.temporary matches 0 run function test:machine/eject with storage test: machine_work.items[0]
data remove storage test: machine_work.items[0]
function test:machine/input/clean_loop
