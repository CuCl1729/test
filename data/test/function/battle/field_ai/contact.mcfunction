#> test:battle/field_ai/contact
# @s = プレイヤーに接触した敵。プレイヤーが殴って開始する場合と同じ経路(test:battle/start)を使う
# (battle/setupは戦闘開始位置の8マス以内にいる敵・プレイヤーを自動的に巻き込むので、
#  ここでは戦闘のきっかけになるだけでよい)

tellraw @a ["",{selector:"@s"},{text:" に襲われた！",color:red}]

function test:battle/start
