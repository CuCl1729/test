#> test:machine/port/sort_item_loop
# @s = 機械のマーカー(実行位置は搬入口)。machine_work.items(搬入口の中身のコピー)を1スロットずつ:
# - 燃料(asset.fuel にあるアイテムid)は、機械の中に蓄える(上限を超える分は搬入口に残す)
# - この機械が受け付ける原石は、そのまま残す(test:machine/input/accepts)
# - それ以外(原石でないもの・段階の合わない原石・目印など)は、出すもの(machine_work.drop)へ移す(自動化の列が詰まらないように)

execute unless data storage test: machine_work.items[0] run return 0

scoreboard players set #machine_ok test.temporary 0
execute store result score #machine_ok test.temporary run function test:machine/fuel/is_fuel with storage test: machine_work.items[0]
execute if score #machine_ok test.temporary matches 1 run function test:machine/port/fuel_in with storage test: machine_work.items[0]
execute if score #machine_ok test.temporary matches 0 store result score #machine_ok test.temporary run function test:machine/input/accepts
execute if score #machine_ok test.temporary matches 0 run function test:machine/eject with storage test: machine_work.items[0]

data remove storage test: machine_work.items[0]
function test:machine/port/sort_item_loop
