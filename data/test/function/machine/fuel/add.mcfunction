#> test:machine/fuel/add
# @s = 機械のマーカー。@macro id: 燃料のアイテムid(ほかのキーも渡ってくるが使わない)。1個ぶんの回数を残りの燃料に足す

scoreboard players set #machine_fuel_add test.temporary 0
$execute store result score #machine_fuel_add test.temporary run data get storage test: asset.fuel."$(id)".count
scoreboard players operation @s test.machine.fuel += #machine_fuel_add test.temporary
