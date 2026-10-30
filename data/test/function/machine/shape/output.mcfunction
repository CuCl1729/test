#> test:machine/shape/output
# 実行位置 = 搬出口。@macro x/y/z: 搬出口の、核からのずれ。置いたときの向き(facing)の隣を、送り先にする。
# 送り先が機械の中(核からのずれが3方向とも -1..1)なら、内側を向いているので数えない(自分の搬入口へ戻る輪にならないように)。
# 外向きなら数えて、machine_work.outputs に {x,y,z(搬出口), tx,ty,tz(送り先)} を足す(どちらも核からのずれ)

$scoreboard players set #port_x test.temporary $(x)
$scoreboard players set #port_y test.temporary $(y)
$scoreboard players set #port_z test.temporary $(z)
execute if block ~ ~ ~ #test:machine_outputs[facing=north] run scoreboard players remove #port_z test.temporary 1
execute if block ~ ~ ~ #test:machine_outputs[facing=south] run scoreboard players add #port_z test.temporary 1
execute if block ~ ~ ~ #test:machine_outputs[facing=west] run scoreboard players remove #port_x test.temporary 1
execute if block ~ ~ ~ #test:machine_outputs[facing=east] run scoreboard players add #port_x test.temporary 1
execute if block ~ ~ ~ #test:machine_outputs[facing=down] run scoreboard players remove #port_y test.temporary 1
execute if block ~ ~ ~ #test:machine_outputs[facing=up] run scoreboard players add #port_y test.temporary 1
execute if score #port_x test.temporary matches -1..1 if score #port_y test.temporary matches -1..1 if score #port_z test.temporary matches -1..1 run return 1

scoreboard players add #machine_outputs test.temporary 1
$data modify storage test: machine_work.port set value {x:$(x),y:$(y),z:$(z),tx:0,ty:0,tz:0}
execute store result storage test: machine_work.port.tx int 1 run scoreboard players get #port_x test.temporary
execute store result storage test: machine_work.port.ty int 1 run scoreboard players get #port_y test.temporary
execute store result storage test: machine_work.port.tz int 1 run scoreboard players get #port_z test.temporary
data modify storage test: machine_work.outputs append from storage test: machine_work.port
return 1
