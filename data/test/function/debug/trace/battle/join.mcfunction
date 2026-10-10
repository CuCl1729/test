#> test:debug/trace/battle/join
# @s = 戦闘に参加したエンティティ(test:battle/joinでIDを受け取った直後)

tellraw @a [{text:"[戦闘] ",color:aqua},{text:"参加: ",color:gray},{selector:"@s"},{text:" → ID ",color:gray},{score:{name:"@s",objective:"test.battle.id"},color:white}]
