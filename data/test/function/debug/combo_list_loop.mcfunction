#> test:debug/combo_list_loop
# @s = 実行したプレイヤー。debug_work.combo_queue を1行ずつ出す
execute unless data storage test: debug_work.combo_queue[0] run return 0

data modify storage test: debug_work.combo_one set from storage test: debug_work.combo_queue[0]
data remove storage test: debug_work.combo_queue[0]
tellraw @s [{nbt:"debug_work.combo_one.desc",storage:"test:",color:white},{text:" "},{nbt:"debug_work.combo_one.emitter",storage:"test:",color:gray},{text:" 要 ",color:dark_gray},{nbt:"debug_work.combo_one.require[]",storage:"test:",separator:"+",color:aqua},{text:" 不可 ",color:dark_gray},{nbt:"debug_work.combo_one.forbid[]",storage:"test:",separator:"+",color:red}]

function test:debug/combo_list_loop
