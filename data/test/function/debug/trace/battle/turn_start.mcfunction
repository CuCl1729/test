#> test:debug/trace/battle/turn_start
# @s = 手番が回ってきたエンティティ(test:battle/turn_start_actorから)

tellraw @a [{text:"[戦闘] ",color:aqua},{text:"手番: ",color:gray},{selector:"@s"},{text:" (順番 ",color:gray},{score:{name:"@s",objective:"test.battle.turn_order"},color:white},{text:") HP ",color:gray},{score:{name:"@s",objective:"test.status.hp"},color:white},{text:"/",color:gray},{score:{name:"@s",objective:"test.status.hp_max"},color:white},{text:" MP ",color:gray},{score:{name:"@s",objective:"test.status.mp"},color:white}]
