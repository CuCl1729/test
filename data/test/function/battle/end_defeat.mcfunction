tellraw @a ["",{text:"戦闘に敗北した...",color:red}]
execute if score #log_battle test.debug.enabled matches 1 run function test:debug/trace/battle/end {result:"敗北"}
function test:battle/end