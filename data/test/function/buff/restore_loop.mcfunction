#> test:buff/restore_loop
# buff_work.out を末尾から取り出して buff_work.list へ積み直す(step_loopで反転した順序を戻す)

execute unless data storage test: buff_work.out[-1] run return 0

data modify storage test: buff_work.list append from storage test: buff_work.out[-1]
data remove storage test: buff_work.out[-1]

function test:buff/restore_loop
