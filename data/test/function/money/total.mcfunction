#> test:money/total
# @s = プレイヤー。持っているコインの合計と口座の残高を足したものを返す(条件 money>= と店の表示)

execute store result score #mt test.temporary run function test:money/coins
scoreboard players add @s test.money 0
scoreboard players operation #mt test.temporary += @s test.money
return run scoreboard players get #mt test.temporary
