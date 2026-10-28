tellraw @a[distance=..64] ["",{text:"戦闘に勝利した！",color:green}]
execute if score #log_battle test.debug.enabled matches 1 run function test:debug/trace/battle/end {result:"勝利"}

function test:battle/end
