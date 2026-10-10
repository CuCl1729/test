#> test:debug/trace/battle/end
# @s = 勝敗を判定したエンティティ(test.battle.idを持つ)。@macro result: 勝利 | 敗北

$tellraw @a [{text:"[戦闘] ",color:aqua},{text:"終了: ID ",color:gray},{score:{name:"@s",objective:"test.battle.id"},color:white},{text:" $(result)",color:white}]
