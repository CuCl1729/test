#> test:battle/join
#
# @s を、最も近くにある戦闘マーカーの戦闘に参加させる。
# 乱入(マーカーを攻撃)の場合もこの関数をそのまま呼べば良い。

execute if score @s test.battle.id matches 1.. run return 0

scoreboard players operation @s test.battle.id = @e[tag=battle_marker,sort=nearest,limit=1] test.battle.id
scoreboard players add @e[tag=battle_marker,sort=nearest,limit=1] test.battle.member_count 1
scoreboard players operation @s test.battle.turn_order = @e[tag=battle_marker,sort=nearest,limit=1] test.battle.member_count

tag @s add battle_member