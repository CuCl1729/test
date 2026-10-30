#> test:factory/enter
# @s = 工場の外にいるプレイヤー。今の場所(ディメンション・座標・向き)を個別ストレージ(oh_my_dat)の factory_return に記録し、
# 区画が無ければ割り当て、区画へ移す(test:factory/go_try)。区画がまだできていなければ tag=factory_going を付けておき、
# test:tick が次のtick以降に試し直す(できる前に移すと、何も無い空中に出てしまうため)

function #oh_my_dat:please
data modify storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].factory_return set value {dim:"",x:0.0d,y:0.0d,z:0.0d,yaw:0.0f,pitch:0.0f}
data modify storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].factory_return.dim set from entity @s Dimension
data modify storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].factory_return.x set from entity @s Pos[0]
data modify storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].factory_return.y set from entity @s Pos[1]
data modify storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].factory_return.z set from entity @s Pos[2]
data modify storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].factory_return.yaw set from entity @s Rotation[0]
data modify storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].factory_return.pitch set from entity @s Rotation[1]

function test:factory/assign
tag @s add factory_going
function test:factory/go_try
execute if entity @s[tag=factory_going] run tellraw @s {text:"工場を準備中…",color:"gray"}
