#> test:debug/trace/battle/enemy_action
# @s = 手番の敵。test:battle/enemy_ai/decideで抽選した直後(抽選値から重みを引いていく前)に呼ばれる

tellraw @a [{text:"[戦闘] ",color:aqua},{text:"敵の行動抽選: ",color:gray},{selector:"@s"},{text:" 抽選値 ",color:gray},{score:{name:"#roll",objective:"test.buff.work"},color:white},{text:" / 攻撃 ",color:gray},{score:{name:"#attack_weight",objective:"test.buff.work"},color:white},{text:" 防御 ",color:gray},{score:{name:"#defend_weight",objective:"test.buff.work"},color:white},{text:" 合計 ",color:gray},{score:{name:"#total_weight",objective:"test.buff.work"},color:white},{text:" (残りはギミック)",color:gray}]
