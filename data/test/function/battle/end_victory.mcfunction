tellraw @a[distance=..64] ["",{text:"戦闘に勝利した！",color:green}]
execute if score #log_battle test.debug.enabled matches 1 run function test:debug/trace/battle/end {result:"勝利"}

scoreboard players operation #battle_reward test.battle.id = @s test.battle.id

execute as @e[tag=battle_member,tag=enemy,distance=..64] if score @s test.battle.id = #battle_reward test.battle.id run function test:battle/grant_reward

function test:battle/end