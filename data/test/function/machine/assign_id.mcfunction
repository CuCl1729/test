#> test:machine/assign_id
# @s = 機械のマーカー。機械ごとの番号(test.machine.id、1から)を振る。ゴースト(足りない位置の表示)がどの機械のものかの目印

scoreboard players add #machine_next test.machine.id 1
scoreboard players operation @s test.machine.id = #machine_next test.machine.id
