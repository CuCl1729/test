#> test:machine/shape/input
# @macro x/y/z: 搬入口の、核からのずれ。数えて machine_work.inputs に足す

scoreboard players add #machine_inputs test.temporary 1
$data modify storage test: machine_work.inputs append value {x:$(x),y:$(y),z:$(z)}
return 1
