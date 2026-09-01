#> test:buff/tick_second
# @s = バフ保持者。リアルタイム戦闘での1秒ぶんの経過

scoreboard players set #buff_step test.buff.work 1
function test:buff/step
