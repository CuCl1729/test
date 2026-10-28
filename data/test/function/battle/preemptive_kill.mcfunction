#> test:battle/preemptive_kill
# @s = 先制攻撃で敵を撃破したプレイヤー。アリーナのセットアップを行わず、その場で報酬を渡して勝利扱いにする
# (範囲攻撃でまとめて倒した場合は、倒した敵の全員分を渡す)

tellraw @a[distance=..32] ["",{text:"先制攻撃で撃破した！",color:green}]

tag @s add battle_reward_recipient
execute as @e[tag=hit,tag=enemy,scores={test.status.hp=..0}] run function test:battle/grant_reward
tag @s remove battle_reward_recipient
