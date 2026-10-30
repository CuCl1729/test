#> test:debug/spawn_machine
# @macro id: 機械の種類(init/asset/machine の asset.machine.<id>)。実行位置を一番下の段の真ん中として、その1つ上に機械の核を置く
# (debug/spawn_station と同じ形。エッグを足元に使ったのと同じ)。足元が床(#test:machine_floor)でなければ、エッグが返ってくる

$execute align xyz positioned ~0.5 ~0.5 ~0.5 run summon armor_stand ~ ~ ~ {Tags:["machine","summoned"],Invulnerable:1b,Invisible:1b,Marker:1b,NoGravity:1b,data:{machine:{id:"$(id)"}}}
execute as @n[tag=summoned,tag=machine] at @s run function test:machine/place
