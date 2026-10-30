#> test:machine/port/fuel_in
# @s = 機械のマーカー(実行位置は搬入口)。@macro id/count/Slot: 燃料のスロット(ほかのキーも渡ってくるが使わない)。
# 1個 = asset.fuel."<id>".count 回分(×100)を、蓄えた燃料(test.machine.fuel)に足す。上限(#machine_fuel_max)までに入る個数だけ取り込み、
# 取り込んだ分だけ搬入口から減らす(全部入ればスロットごと消える)

scoreboard players set #fuel_per test.temporary 0
$execute store result score #fuel_per test.temporary run data get storage test: asset.fuel."$(id)".count
scoreboard players operation #fuel_per test.temporary *= #100 test.constant
execute if score #fuel_per test.temporary matches ..0 run return 0

# 入る個数 = min(スロットの個数, (上限 − 今の燃料) ÷ 1個の量)
scoreboard players operation #fuel_n test.temporary = #machine_fuel_max test.temporary
scoreboard players operation #fuel_n test.temporary -= @s test.machine.fuel
scoreboard players operation #fuel_n test.temporary /= #fuel_per test.temporary
$execute if score #fuel_n test.temporary matches $(count).. run scoreboard players set #fuel_n test.temporary $(count)
execute if score #fuel_n test.temporary matches ..0 run return 0

scoreboard players operation #fuel_per test.temporary *= #fuel_n test.temporary
scoreboard players operation @s test.machine.fuel += #fuel_per test.temporary

$scoreboard players set #fuel_left test.temporary $(count)
scoreboard players operation #fuel_left test.temporary -= #fuel_n test.temporary
$execute if score #fuel_left test.temporary matches ..0 run return run data remove block ~ ~ ~ Items[{Slot:$(Slot)b}]
$execute store result block ~ ~ ~ Items[{Slot:$(Slot)b}].count int 1 run scoreboard players get #fuel_left test.temporary
