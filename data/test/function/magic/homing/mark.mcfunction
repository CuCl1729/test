#> test:magic/homing/mark
# @s = 狙うことにした敵。まだ通し番号が無ければ振る。
# 「距離」ではなく「番号」で相手を覚えるので、近い敵が現れても乗り換えず同じ相手を追い続けられる
execute unless score @s test.magic.eid matches 1.. run scoreboard players add #eid test.time 1
execute unless score @s test.magic.eid matches 1.. run scoreboard players operation @s test.magic.eid = #eid test.time
scoreboard players operation #homing_eid test.temporary = @s test.magic.eid
scoreboard players set #homing_found test.temporary 1
