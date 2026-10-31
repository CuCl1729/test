#> test:research/scan/bar
# @s = プレイヤー。#scan_t(0〜18 tick)を5マスの進み具合にしてアクションバーに出す

execute if score #scan_t test.temporary matches 0..3 run title @s actionbar [{text:"調べ中… ",color:"gray"},{text:"□□□□□",color:"dark_gray"}]
execute if score #scan_t test.temporary matches 4..7 run title @s actionbar [{text:"調べ中… ",color:"gray"},{text:"■",color:"aqua"},{text:"□□□□",color:"dark_gray"}]
execute if score #scan_t test.temporary matches 8..11 run title @s actionbar [{text:"調べ中… ",color:"gray"},{text:"■■",color:"aqua"},{text:"□□□",color:"dark_gray"}]
execute if score #scan_t test.temporary matches 12..15 run title @s actionbar [{text:"調べ中… ",color:"gray"},{text:"■■■",color:"aqua"},{text:"□□",color:"dark_gray"}]
execute if score #scan_t test.temporary matches 16.. run title @s actionbar [{text:"調べ中… ",color:"gray"},{text:"■■■■",color:"aqua"},{text:"□",color:"dark_gray"}]
