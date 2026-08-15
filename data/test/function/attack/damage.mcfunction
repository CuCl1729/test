# 通常のリアルタイムダメージ。既にターン制バトルに参加している相手(battle_member)には当てない。
# ただし戦闘開始のきっかけになる一撃はこの時点ではまだbattle_memberではないため、先制攻撃として通る。
execute as @e[tag=hit,tag=!battle_marker,tag=!battle_member] run function test:damage/

# 先制攻撃で撃破した場合はアリーナのセットアップを省略し、その場で勝利扱いにする
execute if dimension test:turn if entity @e[tag=hit,tag=enemy,scores={test.status.hp=..0}] unless score @s test.battle.id matches 1.. run function test:battle/preemptive_kill
execute unless entity @e[tag=hit,tag=enemy,scores={test.status.hp=..0}] if dimension test:turn if entity @e[tag=hit,tag=enemy] unless score @s test.battle.id matches 1.. run function test:battle/start

execute if entity @e[tag=hit,tag=battle_marker] run function test:battle/join

# 対象が戦闘開始でtest:arenaへ転送された場合、この時点のtag @eはtest:turn側しか見えないため個別に消す
tag @e remove hit
execute in test:arena run tag @e remove hit