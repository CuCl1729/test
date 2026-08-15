#> test:battle/preemptive_kill
# @s = 先制攻撃で敵を撃破したプレイヤー。アリーナのセットアップを行わず、その場で報酬を渡して勝利扱いにする

tellraw @a ["",{text:"先制攻撃で撃破した！",color:green}]

execute store result score #reward test.temporary run scoreboard players get @e[tag=hit,tag=enemy,limit=1] test.status.exp
data modify storage test: battle.temporary.loot_table set from entity @e[tag=hit,tag=enemy,limit=1] data.loot_table

function test:battle/grant_reward_to_player with storage test: battle.temporary
