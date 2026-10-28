# ターン制の戦闘中の敵は、報酬を手番の終わり(test:battle/proc_all)に渡すので印を付ける
# (倒した敵はこのtickの終わりに消えるため、勝利したときにはもういない。2回目以降は付けない)
execute if entity @s[type=!player,tag=enemy,tag=battle_member,tag=!kill] run tag @s add battle_reward_pending
tag @s[type=!player] add kill

execute if entity @s[type=player,tag=!downed] if dimension test:action run function test:status/downed_start
