#> test:battle/start
#
# @s = 戦闘のきっかけとなった側のエンティティ(マーカー設置位置の基準)
# 事前に、もう一方の当事者へ"battle_opponent"タグを付けておくこと

execute if score @s test.battle.id matches 1.. run return 0

scoreboard players add #battle test.battle.next_id 1

summon marker ~ ~ ~ {Tags:[battle_marker]}
scoreboard players operation @e[tag=battle_marker,sort=nearest,limit=1] test.battle.id = #battle test.battle.next_id
scoreboard players set @e[tag=battle_marker,sort=nearest,limit=1] test.battle.current_turn 1
scoreboard players set @e[tag=battle_marker,sort=nearest,limit=1] test.battle.member_count 0

function test:battle/join
execute as @a[distance=..8] at @s unless score @s test.battle.id matches 1.. run function test:battle/join
execute as @e[tag=enemy,distance=..8] at @s unless score @s test.battle.id matches 1.. run function test:battle/join
