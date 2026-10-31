#> test:farm/plant
# @s = 魔法作物の種を右クリックしたプレイヤー(test:trigger/right_click/mainhand から)。@macro magic_seed: 魔法作物のid。
# 目の位置から視線の先へ 0.1 ずつ(5ブロックまで)進めて、最初に当たったブロックに植える(test:farm/ray)。
# 右クリックを押している間は毎tick呼ばれるので、植えられないときの理由はアクションバーに出す(チャットを流さない)

execute at @s unless dimension test:factory run return run title @s actionbar {text:"工場の中で植える",color:"gray"}
# 研究で解放していない魔法作物は植えられない(oh_my_dat は呼び出し元の right_click/mainhand で @s を指している)
$execute unless data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.unlock.crop.$(magic_seed) run return run title @s actionbar {text:"未研究",color:"red"}
$data modify storage test: farm_work.seed set value {id:"$(magic_seed)"}
scoreboard players set #farm_ray test.temporary 50
execute at @s anchored eyes positioned ^ ^ ^ anchored feet run function test:farm/ray
