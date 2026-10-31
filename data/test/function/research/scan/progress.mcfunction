#> test:research/scan/progress
# @s = プレイヤー。@macro found: 見ている観測のid。#scan_t = 見続けている tick 数(0から)。
# 20tick 未満なら進み具合、調べ済みなら「調べ済み」、初めてなら調べ終える

execute if score #scan_t test.temporary matches ..18 run return run function test:research/scan/bar
$execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.research.scanned.$(found) run return run title @s actionbar {text:"調べ済み",color:"gray"}
$function test:research/scan/complete with storage test: asset.scan.$(found)
