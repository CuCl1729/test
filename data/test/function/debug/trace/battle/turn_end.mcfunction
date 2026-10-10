#> test:debug/trace/battle/turn_end
# @s = 行動を終えたエンティティ(test:battle/turn_endから)

tellraw @a [{text:"[戦闘] ",color:aqua},{text:"手番終了: ",color:gray},{selector:"@s"}]
