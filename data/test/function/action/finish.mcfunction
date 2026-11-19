# 先制攻撃で撃破した場合はアリーナのセットアップを省略し、その場で勝利扱いにする
execute if dimension test:turn if entity @e[tag=hit,tag=enemy,scores={test.status.hp=..0}] unless score @s test.battle.id matches 1.. run function test:battle/preemptive_kill
execute unless entity @e[tag=hit,tag=enemy,scores={test.status.hp=..0}] if dimension test:turn if entity @e[tag=hit,tag=enemy] unless score @s test.battle.id matches 1.. run function test:battle/start

# 戦闘中の入り口(フィールドに残る battle_entrance)を叩くと、その戦闘に途中参加する
execute at @e[tag=hit,tag=battle_entrance,limit=1] run function test:battle/join

# 対象が戦闘開始でtest:arenaへ転送された場合、この時点のtag @eはtest:turn側しか見えないため個別に消す
tag @e remove hit
execute in test:arena run tag @e remove hit
