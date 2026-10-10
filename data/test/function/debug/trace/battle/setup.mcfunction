#> test:debug/trace/battle/setup
# @s = 戦闘のきっかけとなったエンティティ。@macro arena: 使うアリーナ番号(test:battle/setupから)

$tellraw @a [{text:"[戦闘] ",color:aqua},{text:"開始: ID ",color:gray},{score:{name:"#battle",objective:"test.battle.next_id"},color:white},{text:" / アリーナ $(arena) / きっかけ ",color:gray},{selector:"@s"}]
