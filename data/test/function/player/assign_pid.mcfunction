#> test:player/assign_pid
# @s = まだ番号の無いプレイヤー。プレイヤーの番号 test.pid(1から)を配る(店・銀行のトロッコの持ち主と、UIアイテムの印に使う)

scoreboard players add #pid_next test.pid 1
scoreboard players operation @s test.pid = #pid_next test.pid
